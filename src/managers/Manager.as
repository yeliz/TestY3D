package managers
{
	import com.yogurt3d.core.sceneobjects.SceneObjectContainer;
	import com.yogurt3d.core.texture.TextureMap;
	
	import flash.display.Scene;
	import flash.utils.Dictionary;

	public class Manager
	{
		public var sceneObjs:Dictionary;
		
		public function Manager()
		{
		}
		
		public function get	emmisiveMaps():Dictionary{
			return null;
		}
		
		public function get specMasks():Dictionary{
			return null;
		}
		
		public function get specMaps():Dictionary{
			return null;
		}
		
		public function get models():Dictionary{
			return null;
		}
	
		public function get refMaps():Dictionary{
			return null;
		}
		
		public function getUsualTextures(_key:String):TextureMap{
			return null;
		}
		
		public function get textures():Dictionary{
			return null;
		}
		
		
		public function getTexture(_key:String):TextureMap{
			
			return null;
		}
		
		public function getLightMap(_key:String):TextureMap{
			
			return null;
		}
		public function getSpecularMap(_key:String):TextureMap{
			return null;
		
		}
		
		public function getEmmisiveMask(_key:String):TextureMap{
			return null;
			
		}
		
		public function getSpecularMask(_key:String):TextureMap{
			return null;
			
		}
		
		public function get lightMaps():Dictionary{
			return null;
		}
		
		public function getRefMap(_key:String):TextureMap{
			
			return null;
		}
		
		public function get avatar():SceneObjectContainer{
			return null;
		}
	}
}