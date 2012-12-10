package location
{
	public class NumanMeydan extends Location
	{
		private var _path:String = "../resources/numanMeydan/";
		public function NumanMeydan()
		{
			super("NumanMeydan");
			
			models["water_pool"] 	= _path+"water_pool.y3d";
			models["water_fall"] 	= _path+"water_fall.y3d";
			models["walls"] 		= _path+"walls.y3d";
			models["tree02"] 		= _path+"tree02.y3d";
			models["stucco"] 		= _path+"stucco.y3d";
			models["roof_cover"] 	= _path+"roof_cover.y3d";
		//	models["roof_arc"] 		= _path+"roof_arc.y3d";
			models["roof"] 			= _path+"roof.y3d";
			models["pots"] 			= _path+"pots.y3d";
			models["pool"] 			= _path+"pool.y3d";
			models["plant07"] 		= _path+"plant07.y3d";
			models["plant04"] 		= _path+"plant04.y3d";
			models["plant02"] 		= _path+"plant02.y3d";
			models["plant01"] 		= _path+"plant01.y3d";
			models["light_wall"] 	= _path+"light_wall.y3d";
			models["light_hanging"] = _path+"light_hanging.y3d";
			models["grass"] 		= _path+"grass.y3d";
			models["granite"] 		= _path+"granite.y3d";
			models["floor"] 		= _path+"floor.y3d";
			models["concrete"] 		= _path+"concrete.y3d";
			models["bench"] 		= _path+"bench.y3d";
			
			textures["water_fall"] 		= _path+"water_fall.jpg";
			textures["water_pool"] 		= _path+"water_pool.jpg";
			textures["walls"] 			= _path+"walls_diffuse.jpg";
			textures["tree02"] 			= _path+"palm_small.png";
			textures["stucco"] 			= _path+"stucco_diffuse.jpg";
			textures["roof_cover"] 		= _path+"honeycomb.PNG";
			textures["roof_arc"] 		= _path+"roof_arch_diffuse.png";
			textures["roof"] 			= _path+"roof_diffuse.jpg";
			textures["pots"] 			= _path+"pots_diffuse.jpg";
			textures["pool"] 			= _path+"pool_diffuse.jpg";
			textures["plant07"] 		= _path+"birch.png";
			textures["plant04"] 		= _path+"flowerpink.png";
			textures["plant02"] 		= _path+"bush02.png";
			textures["plant01"] 		= _path+"bush01.png";
			textures["light_wall"] 		= _path+"light_wall_diffuse.jpg";
		//	textures["light_hanging"] 	= _path+"light_hanging.y3d";
			textures["grass"] 			= _path+"grass_diffuse.jpg";
			textures["granite"] 		= _path+"granite_diffuse.jpg";
			textures["floor"] 			= _path+"floor_diffuse.jpg";
			textures["concrete"] 		= _path+"concrete_diffuse.jpg";
			textures["bench"] 			= _path+"bench_diffuse.jpg";
			
			
			//lightMaps["water_fall"] 		= _path+"water_fall.jpg";
		//	lightMaps["water_pool"] 		= _path+"water_pool.jpg";
			lightMaps["walls"] 			= _path+"walls_light.jpg";
			//lightMaps["tree02"] 			= _path+"palm_small.png";
			lightMaps["stucco"] 			= _path+"stucco_light.jpg";
		//	lightMaps["roof_cover"] 		= _path+"honeycomb.PNG";
		//	lightMaps["roof_arc"] 		= _path+"roof_arch_diffuse.png";
			lightMaps["roof"] 			= _path+"roof_light.jpg";
		//	lightMaps["pots"] 			= _path+"pots_diffuse.jpg";
			lightMaps["pool"] 			= _path+"pool_light.jpg";
//			lightMaps["plant07"] 		= _path+"birch.png";
//			lightMaps["plant04"] 		= _path+"flowerpink.png";
//			lightMaps["plant02"] 		= _path+"bush02.png";
//			lightMaps["plant01"] 		= _path+"bush01.png";
		//	lightMaps["light_wall"] 		= _path+"light_wall_diffuse.jpg";
			//	textures["light_hanging"] 	= _path+"light_hanging.y3d";
			lightMaps["grass"] 			= _path+"grass_light.jpg";
			lightMaps["granite"] 		= _path+"granite_light.jpg";
			lightMaps["floor"] 			= _path+"floor_light.jpg";
			lightMaps["concrete"] 		= _path+"concrete_light.jpg";
		//	lightMaps["bench"] 			= _path+"bench_diffuse.jpg";
			
			refMaps["sp1"] 			= "../resources/sp1.png";
			refMaps["sp2"] 			= "../resources/sp2.png";
			refMaps["sp3"] 			= "../resources/sp3.png";
			refMaps["sp4"] 			= "../resources/sp4.png";
			refMaps["sp5"] 			= "../resources/sp5.png";
			refMaps["Ozer"] 		= "../resources/ozer.jpg";
			
		//	lightMaps["bank"] 			= _path+"bank_light.jpg";
			

			
		}
	}
}