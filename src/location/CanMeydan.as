package location
{
	public class CanMeydan extends Location
	{
		private var _path:String = "../resources/canMeydan/";
		public function CanMeydan()
		{
			super("CanMeydan");
			
			models["bank"] 			= _path+"bank.y3d";
			models["bina01"] 		= _path+"bina01.y3d";
			models["bina02"] 		= _path+"bina02.y3d";	
			models["duvar"] 		= _path+"duvar.y3d";
			models["kemer"] 		= _path+"kemer.y3d";
//			models["kepenk"] 		= _path+"kepenk.y3d";
			models["lambalar"] 		= _path+"lambalar.y3d";
			models["matrakci"] 		= _path+"matrakci.y3d";
			models["merdiven"] 		= _path+"merdiven.y3d";
			models["palmiye"] 		= _path+"palmiye.y3d";
//			models["pencere"] 		= _path+"pencere.y3d";
			models["toprak"] 		= _path+"toprak.y3d";
			models["zemin01"] 		= _path+"zemin01.y3d";
			models["zemin02"] 		= _path+"zemin02.y3d";
			models["zemin03"] 		= _path+"zemin03.y3d";
			models["cicekler"] 		= _path+"cicekler.y3d";
			
			textures["bank"] 			= _path+"bank.jpg";
			textures["bina01"] 			= _path+"bina01.png";
			textures["bina02"] 			= _path+"bina02.jpg";
			textures["cicekler"] 		= _path+"flowers.png";
			textures["duvar"] 			= _path+"duvar.jpg";
			//textures["kemer"] 		= _path+"kemer.y3d";
			textures["kepenk"] 			= _path+"kepenk.jpg";
			textures["lambalar"] 		= _path+"lamba.png";
		//	textures["matrakci"] 		= _path+"matrakci.jpg";
			textures["merdiven"] 		= _path+"mermer.jpg";
			textures["palmiye"] 		= _path+"palmiye.png";
		//	textures["pencere"] 		= _path+"pencere.y3d";
			textures["toprak"] 			= _path+"toprak.jpg";
			textures["zemin01"] 		= _path+"zemin01.jpg";
			textures["zemin02"] 		= _path+"zemin02.jpg";
			textures["zemin03"] 		= _path+"zemin03.jpg";
			
			refMaps["sp1"] 			= "../resources/sp1.png";
			refMaps["sp2"] 			= "../resources/sp2.png";
			refMaps["sp3"] 			= "../resources/sp3.png";
			refMaps["sp4"] 			= "../resources/sp4.png";
			refMaps["sp5"] 			= "../resources/sp5.png";
			
			refMaps["Ozer"] 		= "../resources/ozer.jpg";
			
			lightMaps["bank"] 			= _path+"bank_light.jpg";
		//	lightMaps["bina01"] 		= _path+"bina02_light.jpg";
			lightMaps["bina02"] 		= _path+"bina02_light.jpg";
			lightMaps["cicekler"] 		= _path+"cicekler_light.jpg";
			lightMaps["duvar"] 			= _path+"duvar_light02.jpg";
			lightMaps["kemer"] 			= _path+"kemer_light02.jpg";
			lightMaps["kepenk"] 		= _path+"kepenk_light02.jpg";
			lightMaps["lambalar"] 		= _path+"lambalar_light02.jpg";
			lightMaps["matrakci"] 		= _path+"matrakci.jpg";
			lightMaps["merdiven"] 		= _path+"merdiven_light.jpg";
			lightMaps["palmiye"] 		= _path+"palmiye_light02.jpg";
			//	textures["pencere"] 		= _path+"pencere.y3d";
			lightMaps["toprak"] 		= _path+"toprak_light02.jpg";
			lightMaps["zemin01"] 		= _path+"zemin01_light.jpg";
			lightMaps["zemin02"] 		= _path+"zemin02_light.jpg";
			lightMaps["zemin03"] 		= _path+"zemin03_light.jpg";
			
			emmisiveMaps["zemin02"] 	= _path+"Zemin02_emissive_map.jpg";
			
			
		}
	}
}