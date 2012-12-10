package location
{
	public class Luxuria extends Location
	{
		private var _path:String = "../resources/luxuriaaa/";
		public function Luxuria()
		{
			
			super("Luxuria");
			
			models["Duvar"] 		= _path+"duvar.y3d";
			models["Gumus1"] 		= _path+"gumus01.y3d";
			models["Gumus2"] 		= _path+"gumus02.y3d";
			models["Gumus3"] 		= _path+"gumus03.y3d";
			models["Pencere"] 		= _path+"pencere.y3d";
			models["Porselen"] 		= _path+"porselen.y3d";
			models["Raf1"] 			= _path+"raf01.y3d";
			models["Raf2"] 			= _path+"raf02.y3d";
			models["Raf3"] 			= _path+"raf03.y3d";
			models["RenkliCam"] 	= _path+"renkli_cam.y3d";
			models["Spot"] 			= _path+"spot.y3d";
			models["Tavan"] 		= _path+"tavan.y3d";
			models["Zemin"] 		= _path+"zemin.y3d";
			
			
			textures["Duvar"] 		= _path+"duvar.jpg";
			textures["Gumus1"] 		= _path+"gumus.jpg";
			textures["Gumus2"] 		= _path+"gumus.jpg";
			textures["Gumus3"] 		= _path+"gumus.jpg";
			textures["Raf1"] 		= _path+"raf_01.jpg";
			textures["Porselen"] 	= _path+"porselen.jpg";
			textures["Raf2"] 		= _path+"duvar.jpg";
			textures["Raf3"] 		= _path+"raf_03.jpg";
			textures["RenkliCam"] 	= _path+"renlicam.jpg";
			textures["Spot"] 		= _path+"raf_01.jpg";
			textures["Tavan"] 		= _path+"duvar.jpg";
			textures["Zemin"] 		= _path+"zemin02.jpg";
			textures["Pencere"] 	= _path+"cam.jpg";
			
			refMaps["sp1"] 			= "../resources/sp1.png";
			refMaps["sp2"] 			= "../resources/sp2.png";
			refMaps["sp3"] 			= "../resources/sp3.png";
			refMaps["sp4"] 			= "../resources/sp4.png";
			refMaps["sp5"] 			= "../resources/sp5.png";
			
			refMaps["Ozer"] 		= "../resources/ozer.jpg";
			
			
			lightMaps["Duvar"] 		= _path+"luxuria_duvar_light.jpg";
			lightMaps["Gumus1"] 		= _path+"luxuria_gumus01_light.jpg";
			lightMaps["Gumus2"] 		= _path+"luxuria_gumus02_light.jpg";
			lightMaps["Gumus3"] 		= _path+"luxuria_gumus03_light.jpg";
			lightMaps["Porselen"] 		= _path+"luxuria_porselen_light.jpg";
			lightMaps["Raf1"] 			= _path+"luxuria_raf01_light.jpg";
			lightMaps["Raf2"] 			= _path+"luxuria_raf02_light.jpg";
			lightMaps["Raf3"] 			= _path+"luxuria_raf03_light.jpg";
			lightMaps["RenkliCam"] 	= _path+"luxuria_renklicam_light.jpg";
			lightMaps["Spot"] 			= _path+"luxuria_spot_light.jpg";
			lightMaps["Tavan"] 		= _path+"luxuria_tavan_light.jpg";
			lightMaps["Zemin"] 		= _path+"luxuria_zemin_light.jpg";
			
			
			
		}
	}
}