package location
{
	public class SimpleLife extends Location
	{
		private var _path:String = "../resources/simpleLife/";
		public function SimpleLife()
		{
			super("SimpleLife");
			
			models["ceiling"] 						= _path+"ceiling.y3d";
			models["floor"] 						= _path+"floor.y3d";
		//	models["glass"] 						= _path+"glass.y3d";
			models["logo"] 							= _path+"logo.y3d";
			models["product_rattan"] 				= _path+"product_rattan.y3d";
			models["product_silver"] 				= _path+"products_silver.y3d";
			models["shelves"] 						= _path+"shelves.y3d";
			models["walls"] 						= _path+"walls.y3d";
			models["glassbig"] 						= _path+"glassbig.y3d";
			
			prioList = new Vector.<LocObject>;
			prioList.push(new LocObject("ceiling", models["ceiling"]));
			prioList.push(new LocObject("walls", models["walls"]));
			prioList.push(new LocObject("floor", models["floor"]));
			prioList.push(new LocObject("logo", models["logo"]));
			prioList.push(new LocObject("product_rattan", models["product_rattan"]));
			prioList.push(new LocObject("product_silver", models["product_silver"]));
			prioList.push(new LocObject("shelves", models["shelves"]));			
			prioList.push(new LocObject("glassbig", models["glassbig"]));
						
			textures["ceiling"] 					= _path+"ceiling_light.jpg";
			textures["floor"] 						= _path+"floor.jpg";
		//	textures["glass"] 						= _path+"product_glass.jpg";
			textures["glassbig"] 					= _path+"product_glass.jpg";
			textures["logo"] 						= _path+"product_silver.jpg";
			textures["product_rattan"] 				= _path+"common_light.jpg";
			textures["product_silver"] 				= _path+"product_silver.jpg";
			textures["shelves"] 					= _path+"shelves_light.jpg";
			textures["walls"] 						= _path+"common_light.jpg";
				
			lightMaps["product_rattan"] 			= _path+"common_light.jpg";
			lightMaps["floor"] 						= _path+"floor_light.jpg";
		
			
			refMaps["Numan"] 			= _path + "Reflection_map2.PNG";
			refMaps["Ozer"] 			=  _path + "Reflection_map.png";
			
		}
	}
}