shader_type canvas_item;

// 新增：声明屏幕纹理以在 Godot 4 中使用屏幕内容 (替代旧的 SCREEN_TEXTURE)
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

// 原有高光参数 (保持不变)
uniform vec4 shine_color    : source_color = vec4(1.0);        // 高光颜色（含透明度）
uniform float shine_progress: hint_range(0.0, 1.0, 0.01) = 0.0;  // 高光中心位置 (沿对角线的进度)
uniform float shine_size    : hint_range(0.01, 1.0, 0.01) = 0.1;  // 高光带宽度
uniform float shine_angle   : hint_range(0.0, 89.9, 0.1) = 45.0;  // 高光带相对 X 轴的角度 (0° = 水平)

// 原有卡片旋转参数 (假设已有，如没有可自行添加)
uniform float angle_x : hint_range(-90.0, 90.0, 0.1) = 0.0;   // 垂直倾斜角度 (正值表示卡片下倾)
uniform float angle_y : hint_range(-90.0, 90.0, 0.1) = 0.0;   // 水平倾斜角度 (正值表示卡片右倾)

// 新增：透视缩放强度 (0 = 关闭透视效果，1 = 强透视效果)
uniform float perspective_strength : hint_range(0.0, 1.0, 0.01) = 0.3;  // 远近缩放强度

// **函数**：计算四边形透视映射的逆双线性插值，用于纹理采样
// （说明：保持原有的 invBilinear 实现）
vec2 invBilinear(vec2 P, vec2 a, vec2 b, vec2 c, vec2 d) {
    // 原有实现... (这里省略，假定已在原代码中提供)
    // 该函数输入屏幕当前片元的 UV (P) 和四个角对应的 UV 坐标 (a, b, c, d)，
    // 返回插值后的原始纹理 UV。如果 P 在四边形之外，则返回 vec2(-1.0).
    // ...
// **主片元着色**
void fragment() {
    // 1. 计算旋转后四个角的位置 (UV 空间中)
    // 定义卡片四个顶点的初始局部坐标（以卡片中心为原点，边长1）
    vec2 tl = vec2(-0.5, -0.5);  // 原始顶点：左上 (中心偏移 -0.5, -0.5)
    vec2 tr = vec2( 0.5, -0.5);  // 原始顶点：右上
    vec2 br = vec2( 0.5,  0.5);  // 原始顶点：右下
    vec2 bl = vec2(-0.5,  0.5);  // 原始顶点：左下

    // 将角度从度数转换为弧度
    float ax = radians(angle_x);
    float ay = radians(angle_y);
    // 预计算旋转所需的三角函数值
    float cosX = cos(ax);
    float sinX = sin(ax);
    float cosY = cos(ay);
    float sinY = sin(ay);

    // 定义辅助函数：对传入的局部坐标应用旋转和透视投影
    vec2 projectPoint(vec2 p) {
        // 将局部2D坐标扩展为3D坐标 (z=0)，以应用3D旋转
        float x = p.x;
        float y = p.y;
        float z = 0.0;
        // 绕Y轴旋转 (水平旋转)：影响 x 和 z
        float x1 = x * cosY + z * sinY;
        float z1 = -x * sinY + z * cosY;
        // 绕X轴旋转 (垂直旋转)：影响 y 和 z (注意使用上一步的 z1)
        float y1 = y * cosX + z1 * sinX;
        float z2 = -y * sinX + z1 * cosX;
        // 应用透视缩放：根据旋转后 z2 调整 x1, y1 
        // 远离摄像机的点 (正 z2) 会使分母增大从而收缩，该点看起来更小；靠近摄像机的点 (负 z2) 分母减小，点看起来更大
        float div = 1.0 + perspective_strength * z2;
        // 计算最终投影到屏幕的 2D 坐标，并平移回UV坐标系（中心原点 -> UV原点）
        return vec2(x1 / div + 0.5,  y1 / div + 0.5);
    }

    // 计算四个角经过旋转+透视后的 UV 坐标
    vec2 topleftUV     = projectPoint(tl);
    vec2 toprightUV    = projectPoint(tr);
    vec2 bottomrightUV = projectPoint(br);
    vec2 bottomleftUV  = projectPoint(bl);

    // 2. 根据当前片元的 UV，在透视变换后的四边形中反推原始纹理 UV
    vec2 newUV = invBilinear(UV, topleftUV, toprightUV, bottomrightUV, bottomleftUV);

    // 3. 采样纹理颜色：如果未发生透视变形（例如角度为0）或计算出错，则直接使用屏幕纹理的原始 UV
    if (topleftUV.x == 0.0 || toprightUV.x == 0.0) {
        // 未倾斜情况下直接取原始纹理
        COLOR = texture(SCREEN_TEXTURE, UV);
    } else {
        if (newUV == vec2(-1.0)) {
            // 如果计算得到的 UV 无效（片元不在卡片范围内），输出透明
            COLOR = vec4(0.0);
        } else {
            // 用计算出的原始 UV 从屏幕纹理采样，实现卡片的透视扭曲绘制
            COLOR = texture(SCREEN_TEXTURE, newUV);
        }
    }

    // 4. 保持原有的高光绘制逻辑 (shine 模块)
    // （说明：下面假定原代码根据 shine_progress 等计算高光，此处应与原逻辑一致）
    // 计算高光带的位置方向（shine_angle 相对于水平），以及当前片元相对高光中心的位置
    vec2 shine_dir = vec2(cos(radians(shine_angle)), sin(radians(shine_angle)));
    // 将片元坐标转换到以卡片左上为原点的坐标系进行高光计算
    vec2 uv_pos = UV;  // UV 即当前片元在卡片上的坐标 (0~1)
    // 计算片元投影到高光带轴线方向的距离和垂直距离
    float proj = dot(uv_pos - vec2(shine_progress), shine_dir);
    float dist = dot(uv_pos - vec2(shine_progress), vec2(-shine_dir.y, shine_dir.x));
    // 判断该片元是否在高光带内，若是则叠加高光颜色
    if (abs(dist) < shine_size * 0.5) {
        // 根据离高光中心轴线的距离，计算高光强度（可使用平滑阶梯函数）
        float shine_factor = 1.0 - smoothstep(0.0, shine_size * 0.5, abs(dist));
        // 将高光颜色混合到当前像素
        COLOR = mix(COLOR, shine_color, shine_factor);
    }
}
