package location
{
	public class CanDemoMeydan extends Location
	{
		private var _path:String = "../resources/canDemoMeydan/";
		public function CanDemoMeydan()
		{
			super("CanDemoMeydan");
			
			models["bank"] 			= _path+"bank.y3d";
			models["bina01"] 		= _path+"bina01.y3d";
			models["bina02"] 		= _path+"bina02.y3d";	
			models["cicekler"] 		= _path+"cicekler.y3d";
			models["duvar"] 		= _path+"duvar.y3d";
			models["fatboyBoard"] 	= _path+"FatBoy_Board.y3d";
			models["kemer"] 		= _path+"kemer.y3d";
			models["kepenk001"] 	= _path+"kepenk001.y3d";
			models["kepenk003"] 	= _path+"kepenk003.y3d";
			models["kepenk004"] 	= _path+"kepenk004.y3d";
			models["kepenk007"] 	= _path+"kepenk007.y3d";
			models["lambalarDirek"] = _path+"Lambalar_Direk.y3d";
			models["lambalarLamba"] = _path+"Lambalar_Lamba.y3d";
			models["magicVitrin"] 	= _path+"magicformVitrin.y3d";
			models["matrakci"] 		= _path+"matrakci.y3d";
			models["merdiven"] 		= _path+"merdiven.y3d";
			models["migrosVitrin"] 	= _path+"migrosVitrin001.y3d";
			models["palmiye"] 		= _path+"palmiye.y3d";
			models["pencere"] 		= _path+"pencere.y3d";
			models["QtooBoard"] 	= _path+"Qtoo_Board.y3d";
			models["quicksilverVit"] = _path+"quiksilverVitrin.y3d";
			models["toprak"] 		= _path+"toprak.y3d";
			models["yummyVitrin"] 	= _path+"yummy_vitrin.y3d";	
			models["zemin01"] 		= _path+"zemin01.y3d";
			models["zemin02"] 		= _path+"zemin02.y3d";
			models["zemin03"] 		= _path+"zemin03.y3d";
			models["sphere"] 		= _path+"Kure_cift_UV.y3d";
//			
			
			textures["bank"] 			= _path+"bank_01.jpg";
			textures["bina01"] 		= _path+"bina_01.png";
			textures["bina02"] 		= _path+"bina_02.jpg";	
			textures["cicekler"] 		= _path+"Cicekler.png";
			textures["duvar"] 		= _path+"Duvar_01.jpg";
			textures["fatboyBoard"] 	= _path+"Fatboy.jpg";
			textures["kemer"] 		= _path+"bina_01.png";
			textures["kepenk001"] 	= _path+"kepenk.jpg";
			textures["kepenk003"] 	= _path+"kepenk.jpg";
			textures["kepenk004"] 	= _path+"kepenk.jpg";
			textures["kepenk007"] 	= _path+"kepenk.jpg";
			textures["lambalarDirek"] = _path+"Lambalar.png";
			textures["lambalarLamba"] = _path+"Lambalar.png";
			textures["magicVitrin"] 	= _path+"Magicform_vitrin.jpg";
			textures["matrakci"] 		= _path+"Matrakci_01.jpg";
			textures["merdiven"] 		= _path+"Merdivan_01.jpg";
			textures["migrosVitrin"] 	= _path+"migros_vitrin.jpg";
			textures["palmiye"] 		= _path+"palmiye.png";
			textures["pencere"] 		= _path+"pencere.jpg";
			textures["QtooBoard"] 	= _path+"QTOO.jpg";
			textures["quicksilverVit"] = _path+"quiksilverVitrin_diffuse.jpg";
			textures["toprak"] 		= _path+"Toprak_01.jpg";
			textures["yummyVitrin"] 	= _path+"yummy_vitrin.jpg";	
			textures["zemin01"] 		= _path+"zemin_01.jpg";
			textures["zemin02"] 		= _path+"zemin_02.jpg";
			textures["zemin03"] 		= _path+"zemin_03.jpg";
			
			lightMaps["bank"] 			= _path+"Bank_01_Light.jpg";
			lightMaps["bina01"] 		= _path+"Bina_01_Light.jpg";
			lightMaps["bina02"] 		= _path+"Bina_02_Light.jpg";	
			lightMaps["cicekler"] 		= _path+"Cicekler_Light.jpg";
			lightMaps["duvar"] 		= _path+"Duvar_01_Light.jpg";
			lightMaps["fatboyBoard"] 	= _path+"FatBoy_Vitrin_Light.png";
			lightMaps["kemer"] 		= _path+"Kemer_Light.jpg";
			lightMaps["kepenk001"] 	= _path+"Kepenk_01_Light.jpg";
			lightMaps["kepenk003"] 	= _path+"Kepenk_03_Light.jpg";
			lightMaps["kepenk004"] 	= _path+"Kepenk_04_Light.jpg";
			lightMaps["kepenk007"] 	= _path+"Kepenk_07_Light.jpg";
			lightMaps["lambalarDirek"] = _path+"Lambalar_Light.jpg";
			lightMaps["lambalarLamba"] = _path+"Lambalar_Light.jpg";
			lightMaps["magicVitrin"] 	= _path+"MagicForm_Vitrin_Light.png";
			lightMaps["matrakci"] 		= _path+"Matrakci_01_Light.jpg";
			lightMaps["merdiven"] 		= _path+"Merdiven_01_Light.jpg";
			lightMaps["migrosVitrin"] 	= _path+"Migros_Vitrin_Light.png";
			lightMaps["palmiye"] 		= _path+"Palmiye_Light.jpg";
		//	lightMaps["pencere"] 		= _path+"pencere.jpg";
			lightMaps["QtooBoard"] 	= _path+"Qtoo_Vitrin_Light.png";
			lightMaps["quicksilverVit"] = _path+"Quiksilver_Vitrin_Light.png";
			lightMaps["toprak"] 		= _path+"Toprak_01_Light.jpg";
			lightMaps["yummyVitrin"] 	= _path+"Yummy_Vitrin_Light.png";	
			lightMaps["zemin01"] 		= _path+"Zemin_01_Light.jpg";
			lightMaps["zemin02"] 		= _path+"Zemin_02_Light.jpg";
			lightMaps["zemin03"] 		= _path+"Zemin_03_Light.jpg";
			
			emmisiveMaps["bank"] 			= _path+"Bank_Emissive.png";
			emmisiveMaps["bina01"] 		= _path+"Bina_01_Emissive.png";
			emmisiveMaps["bina02"] 		= _path+"Bina_02_Emissive.png";	
			emmisiveMaps["cicekler"] 		= _path+"Cicekler_Emissive.png";
			emmisiveMaps["duvar"] 		= _path+"Duvar_Emissive.png";
			emmisiveMaps["fatboyBoard"] 	= _path+"Fatboy_Emmisive.jpg";
			emmisiveMaps["kemer"] 		= _path+"Kemer_Emissive.png";
			emmisiveMaps["kepenk001"] 	= _path+"Kepenk_01_Emissive.png";
			emmisiveMaps["kepenk003"] 	= _path+"Kepenk_03_Emissive.png";
			emmisiveMaps["kepenk004"] 	= _path+"Kepenk_04_Emissive.png";
			emmisiveMaps["kepenk007"] 	= _path+"Kepenk_07_Emissive.png";
			emmisiveMaps["lambalarLamba"] = _path+"Lambalar_Emmisive.jpg";
			emmisiveMaps["magicVitrin"] 	= _path+"Magicform_vitrin_emmisive.jpg";
			emmisiveMaps["matrakci"] 		= _path+"Matrakci_Emissive.png";
			emmisiveMaps["merdiven"] 		= _path+"Mermer_Emissive.png";
			emmisiveMaps["migrosVitrin"] 	= _path+"migros_vitrin_emmisive.jpg";
			emmisiveMaps["palmiye"] 		= _path+"Palmiye_Emissive.png";
			emmisiveMaps["QtooBoard"] 	= _path+"QTOO_Emmisive.jpg";
			emmisiveMaps["quicksilverVit"] = _path+"quiksilverVitrin_em.jpg";
			emmisiveMaps["yummyVitrin"] 	= _path+"yummy_vitrin_emmisive.jpg";	
			emmisiveMaps["zemin01"] 		= _path+"Zemin_01_Emissive.png";
			emmisiveMaps["zemin02"] 		= _path+"Zemin_02_Emissive.png";
			emmisiveMaps["zemin03"] 		= _path+"Zemin_03_Emissive.png";
	
			
			//lightMaps["bank"] 			= _path+"bank_light.jpg";
			
			//emmisiveMaps["zemin02"] 	= _path+"Zemin02_emissive_map.jpg";
			
			specMasks["zemin01"] 	= _path+"zemin_01_specular.JPG";
		}
	}
}