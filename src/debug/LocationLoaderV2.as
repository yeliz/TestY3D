package debug
{
	import com.yogurt3d.core.sceneobjects.SceneObjectContainer;
	import com.yogurt3d.core.sceneobjects.SceneObjectRenderable;
	import com.yogurt3d.core.setup.SetupBase;
	import com.yogurt3d.core.texture.CubeTextureMap;
	import com.yogurt3d.core.texture.TextureMap;
	import com.yogurt3d.core.utils.TextureMapDefaults;
	import com.yogurt3d.io.loaders.DataLoader;
	import com.yogurt3d.io.loaders.DisplayObjectLoader;
	import com.yogurt3d.io.managers.loadmanagers.LoadManager;
	import com.yogurt3d.io.parsers.TextureMap_Parser;
	import com.yogurt3d.io.parsers.Y3D_Parser;
	import com.yogurt3d.presets.material.MaterialFill;
	import com.yogurt3d.presets.material.yogurtistanv2.MaterialYogurtistanLocationV2;
	import com.yogurt3d.presets.sceneobjects.GeodesicSphereSceneObject;
	
	import flash.net.URLLoaderDataFormat;
	import flash.utils.Dictionary;
	
	import location.LocObject;
	import location.Location;
	import location.Luxuria;
	
	import managers.Manager;
	
	import setup.TestSetup;
	
	import skybox.Desert2SkyBox;
	
	public class LocationLoaderV2 extends Manager
	{
		private var m_setup						:SetupBase;
		private var m_loader					:LoadManager;
		private var _path						:String = "../resources/Kagithane/";
		public var curLocation					:Location;
		public var images						:Dictionary;
		
		public function LocationLoaderV2(_setup:SetupBase)
		{
			
			m_setup = _setup;
			sceneObjs = new Dictionary;
			images = new Dictionary;
			curLocation = new Luxuria;
			
		//	images["colorGradient"] = "../resources/gradient.png";
			images["noise"] = "../resources/noise_tex6.jpg";
			images["noise2"] = "../resources/Noise2D_std.png";
			images["mask"] = "../resources/binoculars_mask.jpg";
			
			
			images["SMap"] = "../resources/defaults/gloss_map.jpg";
			images["SMask"] = "../resources/defaults/SMap.jpg";
			images["EMask"] = "../resources/defaults/Emmisive.jpg";
			
			// "SMap"
			//SMask
			//EMask
			
		}
		
		public override function get emmisiveMaps():Dictionary{
			return curLocation.emmisiveMaps;
		}
		
		public override function get specMasks():Dictionary{
			return curLocation.specMasks;
		}
		public override function getSpecularMask(_key:String):TextureMap{
			
			return m_loader.getLoadedContent(curLocation.specMasks[_key]);
		}
		
		public override function getEmmisiveMask(_key:String):TextureMap{
			
			return m_loader.getLoadedContent(curLocation.emmisiveMaps[_key]);
		}
		
		public override function getSpecularMap(_key:String):TextureMap{
			
			return m_loader.getLoadedContent(curLocation.specMaps[_key]);
		}
		
		public override function get models():Dictionary{
			return curLocation.models;
		}
		
		public override function get textures():Dictionary{
			return curLocation.textures;
		}
		
		public override function get lightMaps():Dictionary{
			return curLocation.lightMaps;
		}
		
		public override function get refMaps():Dictionary{
			return curLocation.refMaps;
		}
		
		public override function get specMaps():Dictionary{
			return curLocation.specMaps;
		}
		
		public override function getUsualTextures(_key:String):TextureMap{
			
			return m_loader.getLoadedContent(images[_key]);
		}
		
		public override function getRefMap(_key:String):TextureMap{
			
			return m_loader.getLoadedContent(curLocation.refMaps[_key]);
		}
		
		public override function getTexture(_key:String):TextureMap{
			
			return m_loader.getLoadedContent(curLocation.textures[_key]);
		}
		
		public override function getLightMap(_key:String):TextureMap{
			
			return m_loader.getLoadedContent(curLocation.lightMaps[_key]);
		}
		
		public function loadResources():void{
			
			m_loader = new LoadManager();
			
			for (var key:Object in curLocation.models) {
				trace("Loading model : "+curLocation.models[key]);
				m_loader.add(curLocation.models[key], DataLoader, Y3D_Parser, {dataFormat: URLLoaderDataFormat.BINARY});
			}
			
			for (key in curLocation.textures) {
				
				trace("Loading Textures: "+curLocation.textures[key]);
				
				if(String(curLocation.textures[key]).indexOf(".atf") != -1){
					m_loader.add( curLocation.textures[key], DataLoader, TextureMap_Parser, {dataFormat: URLLoaderDataFormat.BINARY}  );
				}else{
					m_loader.add( curLocation.textures[key], DisplayObjectLoader, TextureMap_Parser, null, true );
				}
			}
			
			for (key in curLocation.lightMaps) {
				
				trace("Loading Light Maps: "+curLocation.lightMaps[key]);
				
				if(String(curLocation.lightMaps[key]).indexOf(".atf") != -1){
					m_loader.add( curLocation.lightMaps[key], DataLoader, TextureMap_Parser, {dataFormat: URLLoaderDataFormat.BINARY}  );
				}else{
					m_loader.add( curLocation.lightMaps[key], DisplayObjectLoader, TextureMap_Parser, null, true );
				}
			}
			
			for (key in curLocation.refMaps) {
				trace("Loading Ref Maps: "+curLocation.refMaps[key]);
				
				if(String(curLocation.refMaps[key]).indexOf(".atf") != -1){
					m_loader.add( curLocation.refMaps[key], DataLoader, TextureMap_Parser, {dataFormat: URLLoaderDataFormat.BINARY}  );
				}else{
					m_loader.add( curLocation.refMaps[key], DisplayObjectLoader, TextureMap_Parser, null, true );
				}
			}
			
			for (key in curLocation.specMaps) {
				trace("Loading Spec Maps: "+curLocation.specMaps[key]);
				
				if(String(curLocation.specMaps[key]).indexOf(".atf") != -1){
					m_loader.add( curLocation.specMaps[key], DataLoader, TextureMap_Parser, {dataFormat: URLLoaderDataFormat.BINARY}  );
				}else{
					m_loader.add( curLocation.specMaps[key], DisplayObjectLoader, TextureMap_Parser, null, true );
				}
			}
			
			for (key in curLocation.specMasks) {
				trace("Loading Spec Mask: "+curLocation.specMasks[key]);
				
				if(String(curLocation.specMasks[key]).indexOf(".atf") != -1){
					m_loader.add( curLocation.specMasks[key], DataLoader, TextureMap_Parser, {dataFormat: URLLoaderDataFormat.BINARY}  );
				}else{
					m_loader.add( curLocation.specMasks[key], DisplayObjectLoader, TextureMap_Parser, null, true );
				}
			}
			
			for (key in curLocation.emmisiveMaps) {
				trace("Loading Emm Mask: "+curLocation.emmisiveMaps[key]);
				
				if(String(curLocation.emmisiveMaps[key]).indexOf(".atf") != -1){
					m_loader.add( curLocation.emmisiveMaps[key], DataLoader, TextureMap_Parser, {dataFormat: URLLoaderDataFormat.BINARY}  );
				}else{
					m_loader.add( curLocation.emmisiveMaps[key], DisplayObjectLoader, TextureMap_Parser, null, true );
				}
			}
			
			for (key in images) {
				if(String(images[key]).indexOf(".atf") != -1){
					m_loader.add( images[key], DataLoader, TextureMap_Parser, {dataFormat: URLLoaderDataFormat.BINARY}  );
				}else{
					m_loader.add( images[key], DisplayObjectLoader, TextureMap_Parser, null, true );
				}			
			}
		}
		public var cont:SceneObjectContainer = new SceneObjectContainer();
		
		public function get container():SceneObjectContainer{
			return cont;
		}
		public function get createContainer():SceneObjectContainer{
			cont = new SceneObjectContainer();
			
			if(curLocation.prioList == null){
				for (var key:Object in curLocation.models) {
					sceneObjs[key] = new SceneObjectRenderable;
					
					sceneObjs[key].geometry = m_loader.getLoadedContent(curLocation.models[key]);
					sceneObjs[key].material = new MaterialYogurtistanLocationV2(UIManagerV2.GRADIENT);
					sceneObjs[key].interactive = true;
					sceneObjs[key].pickEnabled = true;
					
					
					if(key == "sphere"){
						SceneObjectRenderable(sceneObjs[key]).transformation.y = 70;
						SceneObjectRenderable(sceneObjs[key]).transformation.x = -80;
						SceneObjectRenderable(sceneObjs[key]).transformation.z = -40;
					}
					
					if(curLocation.specMasks[key])
						MaterialYogurtistanLocationV2(sceneObjs[key].material).specularMap = m_loader.getLoadedContent(curLocation.specMasks[key]);	
					if(curLocation.textures[key]){
						MaterialYogurtistanLocationV2(sceneObjs[key].material).colorMap = m_loader.getLoadedContent(curLocation.textures[key]);	
					//	MaterialYogurtistanLocationV2(sceneObjs[key].material).transparent = MaterialYogurtistanLocationV2(sceneObjs[key].material).colorMap.transparent;
						//if(MaterialYogurtistanLocationV2(sceneObjs[key].material).colorMap.transparent)
					}
					if(curLocation.lightMaps[key])
						MaterialYogurtistanLocationV2(sceneObjs[key].material).lightMap = m_loader.getLoadedContent(curLocation.lightMaps[key]);	
					if(curLocation.emmisiveMaps[key])
						MaterialYogurtistanLocationV2(sceneObjs[key].material).emmisiveMask = m_loader.getLoadedContent(curLocation.emmisiveMaps[key]);	
		
					cont.addChild(sceneObjs[key]);
					
					trace("Scene Object Created: ", key, TestSetup(m_setup).scene.getRenderableSet().getRenderableCount(), sceneObjs[key].pickEnabled, MaterialYogurtistanLocationV2(sceneObjs[key].material).transparent);
					
					trace("-------------------------------------------------------------");
				}
			}else{
				
				var obj:LocObject;
				var sky:CubeTextureMap = new Desert2SkyBox().texture;
				for(var i:uint = 0; i < curLocation.prioList.length; i++){
					obj = curLocation.prioList[i];
					
					sceneObjs[obj.key] = new SceneObjectRenderable;
					sceneObjs[obj.key].interactive = true;
					sceneObjs[obj.key].pickEnabled = true;
					sceneObjs[obj.key].geometry = m_loader.getLoadedContent(obj.path);
					sceneObjs[obj.key].material = new MaterialYogurtistanLocationV2(UIManagerV2.GRADIENT);
					trace("Scene Object Created: ", obj.key, TestSetup(m_setup).scene.getRenderableSet().getRenderableCount(), sceneObjs[obj.key].pickEnabled);
					
					if(curLocation.textures[obj.key])
						MaterialYogurtistanLocationV2(sceneObjs[obj.key].material).colorMap = m_loader.getLoadedContent(curLocation.textures[obj.key]);	
					if(curLocation.lightMaps[obj.key])
						MaterialYogurtistanLocationV2(sceneObjs[obj.key].material).lightMap = m_loader.getLoadedContent(curLocation.lightMaps[obj.key]);	
					if(curLocation.emmisiveMaps[obj.key])
						MaterialYogurtistanLocationV2(sceneObjs[obj.key].material).emmisiveMask = m_loader.getLoadedContent(curLocation.emmisiveMaps[obj.key]);	
					if(curLocation.specMasks[obj.key])
						MaterialYogurtistanLocationV2(sceneObjs[obj.key].material).specularMap = m_loader.getLoadedContent(curLocation.specMasks[obj.key]);	
				
					cont.addChild(sceneObjs[obj.key]);
				}					
			}	

			return cont;
		}
		
		public function get loader():LoadManager
		{
			return m_loader;
		}
		
		public function set loader(value:LoadManager):void
		{
			m_loader = value;
		}
	}
}