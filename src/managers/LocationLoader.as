package managers
{
	import com.yogurt3d.core.sceneobjects.SceneObjectContainer;
	import com.yogurt3d.core.sceneobjects.SceneObjectRenderable;
	import com.yogurt3d.core.sceneobjects.event.MouseEvent3D;
	import com.yogurt3d.core.setup.SetupBase;
	import com.yogurt3d.core.texture.TextureMap;
	import com.yogurt3d.io.loaders.DataLoader;
	import com.yogurt3d.io.loaders.DisplayObjectLoader;
	import com.yogurt3d.io.managers.loadmanagers.LoadManager;
	import com.yogurt3d.io.parsers.TextureMap_Parser;
	import com.yogurt3d.io.parsers.Y3D_Parser;
	import com.yogurt3d.presets.material.yogurtistan.MaterialYogurtistanLocation;
	
	import flash.net.URLLoaderDataFormat;
	import flash.utils.Dictionary;
	
	import location.Kagithane;
	import location.LocObject;
	import location.Location;
	import location.Luxuria;
	import location.NumanMeydan;
	import location.SimpleLife;

	public class LocationLoader extends Manager
	{
		private var m_setup						:SetupBase;
		private var m_loader					:LoadManager;
		private var _path						:String = "../resources/Kagithane/";
		public var curLocation					:Location;
		public var images						:Dictionary;
		
		public function LocationLoader(_setup:SetupBase)
		{
			
			m_setup = _setup;
			sceneObjs = new Dictionary;
			images = new Dictionary;
			curLocation = new Luxuria;
			
			images["colorGradient"] = "../resources/gradient.png";
			images["noise"] = "../resources/noise_tex6.jpg";
			images["noise2"] = "../resources/Noise2D_std.png";
			images["mask"] = "../resources/binoculars_mask.jpg";
					
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
			
			for (key in images) {
				if(String(images[key]).indexOf(".atf") != -1){
					m_loader.add( images[key], DataLoader, TextureMap_Parser, {dataFormat: URLLoaderDataFormat.BINARY}  );
				}else{
					m_loader.add( images[key], DisplayObjectLoader, TextureMap_Parser, null, true );
				}			
			}
		}
		public var cont:SceneObjectContainer = new SceneObjectContainer();
//		private function onObjSelected(event:MouseEvent3D):void{
//			
//			for(var i:uint = 0; i < cont.children.length; i++){
//				MaterialYogurtistanLocation((cont.children[i]as SceneObjectRenderable).material).opacity = 1.0;
//			}
//			
//			MaterialYogurtistanLocation((event.currentTarget3d as SceneObjectRenderable).material).opacity = 0.5;
//			
//		}
		
		public function get container():SceneObjectContainer{
		//	var cont:SceneObjectContainer = new SceneObjectContainer();
			
			if(curLocation.prioList == null){
				for (var key:Object in curLocation.models) {
					trace("Scene Object Created: ", key);
					sceneObjs[key] = new SceneObjectRenderable;
					
					sceneObjs[key].geometry = m_loader.getLoadedContent(curLocation.models[key]);
					sceneObjs[key].material = new MaterialYogurtistanLocation();
					sceneObjs[key].interactive = true;
					sceneObjs[key].pickEnabled = true;
				//	(sceneObjs[key] as SceneObjectRenderable).onMouseDoubleClick.add(onObjSelected);
					
					//MaterialYogurtistanLocation(sceneObjs[key].material).reflectionMap = m_loader.getLoadedContent(curLocation.refMaps["Ozer"]);
					if(curLocation.textures[key]){	
						MaterialYogurtistanLocation(sceneObjs[key].material).colorMap = m_loader.getLoadedContent(curLocation.textures[key]);	
					}	
					if(curLocation.lightMaps[key])
						MaterialYogurtistanLocation(sceneObjs[key].material).lightMap = m_loader.getLoadedContent(curLocation.lightMaps[key]);	
//					
//					if(curLocation.specMaps[key])
//						MaterialYogurtistanLocation(sceneObjs[key].material).specularMap = m_loader.getLoadedContent(curLocation.specMaps[key]);	
					
					//				if(key == "Camlar" || key == "Zemin")
					//					MaterialYogurtistanLocation(sceneObjs[key].subShader).reflectionMap = m_loader.getLoadedContent(curLocation.textures["Ozer"]);
					cont.addChild(sceneObjs[key]);
				}
			}else{
			
				var obj:LocObject;
				for(var i:uint = 0; i < curLocation.prioList.length; i++){
					obj = curLocation.prioList[i];
					
					sceneObjs[obj.key] = new SceneObjectRenderable;
					
					sceneObjs[obj.key].geometry = m_loader.getLoadedContent(obj.path);
					sceneObjs[obj.key].material = new MaterialYogurtistanLocation();
					
					if(curLocation.textures[obj.key])
						MaterialYogurtistanLocation(sceneObjs[obj.key].material).colorMap = m_loader.getLoadedContent(curLocation.textures[obj.key]);	
					if(curLocation.lightMaps[obj.key])
						MaterialYogurtistanLocation(sceneObjs[obj.key].material).lightMap = m_loader.getLoadedContent(curLocation.lightMaps[obj.key]);	
					
	
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