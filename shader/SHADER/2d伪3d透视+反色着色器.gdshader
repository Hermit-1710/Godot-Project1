// Hey this is Hei! This shader "fakes" a 3D-camera perspective on CanvasItems.
// License: MIT

shader_type canvas_item;

// Camera FOV
uniform float fov : hint_range(1, 179) = 90;
uniform bool cull_back = true;
uniform float y_rot : hint_range(-180, 180) = 0.0;
uniform float x_rot : hint_range(-180, 180) = 0.0;
// At 0, the image retains its size when unrotated.
// At 1, the image is resized so that it can do a full
// rotation without clipping inside its rect.
uniform float inset : hint_range(0, 1) = 0.0;
// Consider changing this to a uniform and changing it from code
/* ──────────────────  SHINE BLOCK ────────────────── */
/* #1：外部可调参数 */
uniform vec4  shine_color    : source_color = vec4(1.0);   // 高光颜色 & 透明度
uniform float shine_progress : hint_range(0.0, 1.0, 0.01) = 0.0; // 高光中心在对角线上的位置
uniform float shine_size     : hint_range(0.01, 1.0, 0.01) = 0.1; // 带宽
uniform float shine_angle    : hint_range(0.0, 89.9, 0.1) = 45.0; // 与 X 轴夹角（0°=水平）

/* #2：工具函数：把 [inMin,inMax] 映射到 [outMin,outMax] */
float s_scale(float v,float i0,float i1,float o0,float o1){
    return (v-i0)*(o1-o0)/(i1-i0)+o0;
}
/* ─────────────────────────────────────────── */
varying flat vec2 o;
varying vec3 p;
// Creates rotation matrix
void vertex(){
	float sin_b = sin(y_rot / 180.0 * PI);
	float cos_b = cos(y_rot / 180.0 * PI);
	float sin_c = sin(x_rot / 180.0 * PI);
	float cos_c = cos(x_rot / 180.0 * PI);
	
	mat3 inv_rot_mat;
	inv_rot_mat[0][0] = cos_b;
	inv_rot_mat[0][1] = 0.0;
	inv_rot_mat[0][2] = -sin_b;
	
	inv_rot_mat[1][0] = sin_b * sin_c;
	inv_rot_mat[1][1] = cos_c;
	inv_rot_mat[1][2] = cos_b * sin_c;
	
	inv_rot_mat[2][0] = sin_b * cos_c;
	inv_rot_mat[2][1] = -sin_c;
	inv_rot_mat[2][2] = cos_b * cos_c;
	
	
	float t = tan(fov / 360.0 * PI);
	p = inv_rot_mat * vec3((UV - 0.5), 0.5 / t);
	float v = (0.5 / t) + 0.5;
	p.xy *= v * inv_rot_mat[2].z;
	o = v * inv_rot_mat[2].xy;

	VERTEX += (UV - 0.5) / TEXTURE_PIXEL_SIZE * t * (1.0 - inset);
}

void fragment(){
	if (cull_back && p.z <= 0.0) discard;
	  /* 采样扭曲后的纹理 */
    vec2 uv = (p.xy / p.z) - o;
    vec4 col = texture(TEXTURE, uv + 0.5);

    /* 高光计算 */
    float slope = tan(radians(shine_angle));
    /* 把 [0,1] 进度映射到 UV 空间对角线（随带宽补偿） */
    float prog = s_scale(
        shine_progress,
        0.0, 1.0,
        -1.0 - shine_size - shine_size * slope,
         1.0 * slope
    );
    /* 两条 step() 相减得到矩形脉冲 -> 一个亮带 */
    //float band = step(slope * uv.x - uv.y, prog + shine_size + shine_size * slope)
               //- step(slope * uv.x - uv.y, prog);
	//float band2 = step(slope * uv.x - uv.y, prog + shine_size -2.0*shine_size * slope)
               //- step(slope * uv.x - uv.y, prog + 1.0*shine_size * slope);
	//float band3 = step(slope * uv.x - uv.y, prog + shine_size +5.0* shine_size * slope)
               //- step(slope * uv.x - uv.y, prog + 4.8*shine_size * slope);
	//float band4 = step(slope * uv.x - uv.y, prog + shine_size +3.3* shine_size * slope)
               //- step(slope * uv.x - uv.y, prog + 5.2*shine_size * slope);
    ///* 融合到原始颜色：alpha 表示高光强度 */
    //col.rgb = mix(col.rgb, shine_color.rgb, band * shine_color.a);
	//col.rgb = mix(col.rgb, shine_color.rgb, band2 * shine_color.a);
	//col.rgb = mix(col.rgb, shine_color.rgb, band3 * shine_color.a);
	//col.rgb = mix(col.rgb, shine_color.rgb, band4 * shine_color.a);
    /* 四周裁剪（超出贴图 UV 范围时透明）*/
    col.a *= step(max(abs(uv.x), abs(uv.y)), 0.5);
	col = vec4(1.0 - col.r,1.0 - col.g,1.0 - col.b,col.a);
    COLOR = col;
}