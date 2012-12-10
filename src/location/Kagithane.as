package location
{
	public class Kagithane extends Location
	{
		private var _path:String = "../resources/Kagithane/";
		public function Kagithane()
		{
			super("Kagithane");
			
		//	models["Alfali_Urunler"] 		= _path+"Alfali_Urunler.y3d";
		//	models["Arka_Raflar"] 			= _path+"Arka_Raflar.y3d";
			models["Camlar"] 				= _path+"Camlar.y3d";
//			models["Duvar"] 				= _path+"Duvar.y3d";
//			models["Kapi"] 					= _path+"Kapi.y3d";
//			models["Metaller"] 				= _path+"Metaller.y3d";
//			models["On_Raflar"] 			= _path+"On_Raflar.y3d";			
//			models["Orta_Raflar"] 			= _path+"Orta_Raflar.y3d";
//			models["Sag_Raflar"] 			= _path+"Sag_Raflar.y3d";
//			models["Sol_Raflar"] 			= _path+"Sol_Raflar.y3d";
//			models["Tavan"] 				= _path+"Tavan.y3d";
//			models["Zemin"] 				= _path+"Zemin.y3d";
			
			textures["Alfali_Urunler"] 		= _path+"Alfali_Urunler.png";
			textures["Arka_Raflar"] 		= _path+"Urunler_Atlas.png";
			textures["Kapi"] 				= _path+"Urunler_Atlas.png";
			textures["Metaller"] 			= _path+"Urunler_Atlas.png";
			textures["On_Raflar"] 			= _path+"Urunler_Atlas.png";
			textures["Orta_Raflar"] 		= _path+"Urunler_Atlas.png";
			textures["Sag_Raflar"] 			= _path+"Urunler_Atlas.png";
			textures["Sol_Raflar"] 			= _path+"Urunler_Atlas.png";
			textures["Tavan"] 				= _path+"Urunler_Atlas.png";
			textures["Zemin"] 				= _path+"Zemin_Tile.jpg";
			
			refMaps["sp1"] 			= "../resources/sp1.png";
			refMaps["sp2"] 			= "../resources/sp2.png";
			refMaps["sp3"] 			= "../resources/sp3.png";
			refMaps["sp4"] 			= "../resources/sp4.png";
			refMaps["sp5"] 			= "../resources/sp5.png";
			
			refMaps["Ozer"] 				= "../resources/ozer.jpg";
			
			lightMaps["Alfali_Urunler"] 	= _path+"Alfali_Urunler_LM.jpg";
			lightMaps["Arka_Raflar"] 		= _path+"Arka_Raflar_LM.jpg";
			lightMaps["Duvar"] 				= _path+"Duvar_LM.jpg";
			lightMaps["Kapi"] 				= _path+"Kapi_LM.jpg";
			lightMaps["Metaller"] 			= _path+"Metaller_LM.jpg";
			lightMaps["On_Raflar"] 			= _path+"On_Raflar_LM.jpg";
			lightMaps["Orta_Raflar"] 		= _path+"Orta_Raflar_LM.jpg";
			lightMaps["Sag_Raflar"] 		= _path+"Sag_Raflar_LM.jpg";
			lightMaps["Sol_Raflar"] 		= _path+"Sol_Raflar_LM.jpg";
			lightMaps["Tavan"] 				= _path+"Tavan_LM.jpg";
			lightMaps["Zemin"] 				= _path+"Zemin_LM.jpg";
		}
	}
}