package location
{
	public class OzerTest extends Location
	{
		private var _path:String = "../resources/ozerTest/";
		public function OzerTest()
		{
			super();
			
			models["zemin_01"] 				= _path+"zemin_01.y3d";
			
			textures["zemin_01"] 			= _path+"Zemin_01.jpg";
			
			lightMaps["zemin_01"] 			= _path+"Zemin_01_Light.jpg";
			
			specMaps["zemin_01"]			= _path+"Zemin_01_Specular.jpg";
		}
	}
}