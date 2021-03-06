
vec4 shader_main(vec2 st_src,vec4 C){
	vec2 delta=st_src*inv_matrix45_image_dim.zw-inv_matrix45_image_dim.xy;
	vec4 mul=delta.xyxy*inv_matrix0123;
	vec2 uv = mul.xz+mul.yw;
	float alpha=texture2D(tex_segmentation,uv).w;
	
	
	if(alpha>0.8){
		return C;
	}
	
	vec2 bgrt = background_uv_lt.zw;
	vec2 bglb = background_uv_rb.zw;
	vec2 bgwh = bgrt - bglb;
	vec2 bguv = vec2(bglb.x + bgwh.x*(1.0-uv.x), 1.0-(bglb.y + bgwh.y*(1.0-uv.y)));
	vec4 bg_color = texture2D(tex_background,bguv);
	
	if(alpha>0.6){
		alpha = (alpha-0.6)/(0.2);
		return vec4((C*(alpha) + bg_color*(1.0-alpha)).xyz,1.0);
	}else{
		return bg_color;
	}
}
