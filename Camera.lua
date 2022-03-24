--camera
function simple_camera()
	cam_x=player.x-64+(player.w/2)
  	if cam_x<map_start then
    	cam_x=map_start
  	end
  	if cam_x>map_end-128 then
   		cam_x=map_end-128
  	end
  	camera(cam_x,cam_y)
-----------------
 			
 --limit player to map
	if player.x<map_start then
    	player.x=map_start
  	end
  	if player.x>map_end-player.w then
    	player.x=map_end-player.w
  	end
  -----------------------------
	end
end
