--timer

function update_timer()
		game_timer=time()-game_timer_start
end

function draw_timer()
		if crt==true then
		fillp(▤\1|0b.011)
		else
		fillp()
		end
		
		if game_timer<=9.99 then
		rectfill(cam_x,cam_y+121,cam_x+15,cam_y+128,0)
		elseif game_timer<=99.99 then
		rectfill(cam_x,cam_y+121,cam_x+19,cam_y+128,0)
		elseif game_timer<=999.99 then
		rectfill(cam_x,cam_y+121,cam_x+24,cam_y+128,0)
		end
		
		print(flr(game_timer * 100) / 100, cam_x, cam_y+122,7)
end
