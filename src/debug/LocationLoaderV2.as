package debug
{
	import com.yogurt3d.core.animation.controllers.SkinController;
	import com.yogurt3d.core.geoms.SkeletalAnimatedMesh;
	import com.yogurt3d.core.sceneobjects.SceneObjectContainer;
	import com.yogurt3d.core.sceneobjects.SceneObjectRenderable;
	import com.yogurt3d.core.sceneobjects.event.MouseEvent3D;
	import com.yogurt3d.core.setup.SetupBase;
	import com.yogurt3d.core.texture.CubeTextureMap;
	import com.yogurt3d.core.texture.TextureMap;
	import com.yogurt3d.core.utils.Color;
	import com.yogurt3d.core.utils.TextureMapDefaults;
	import com.yogurt3d.io.loaders.DataLoader;
	import com.yogurt3d.io.loaders.DisplayObjectLoader;
	import com.yogurt3d.io.managers.loadmanagers.LoadManager;
	import com.yogurt3d.io.parsers.TextureMap_Parser;
	import com.yogurt3d.io.parsers.Y3D_Parser;
	import com.yogurt3d.io.parsers.YOA_Parser;
	import com.yogurt3d.presets.material.MaterialFill;
	import com.yogurt3d.presets.material.yogurtistan.MaterialYogurtistanAvatar;
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
		private var m_avatarRS					:Dictionary;
		
		public function LocationLoaderV2(_setup:SetupBase)
		{
			
			m_setup = _setup;
			sceneObjs = new Dictionary;
			images = new Dictionary;
			curLocation = new Luxuria;
		
			images["noise"] = "../resources/noise_tex6.jpg";
			images["noise2"] = "../resources/Noise2D_std.png";
			images["mask"] = "../resources/binoculars_mask.jpg";
			
			images["SMap"] = "../resources/defaults/gloss_map.jpg";
			images["SMask"] = "../resources/defaults/SMap.jpg";
			images["EMask"] = "../resources/defaults/Emmisive.jpg";
			
			images["FemaleBody"] = "../resources/avatar/FEMALE/Govde.png";
			images["FemaleSurat"] = "../resources/avatar/FEMALE/Surat_yeni.png";
			images["FemaleSac"] = "../resources/avatar/FEMALE/sac_001_yeni_01.png";
			
			images["SpecularMap"] = "../resources/ozerTest/CheckerBoard.jpg";
			images["SpecularFaceMap"] = "../resources/avatar/FEMALE/Surat_speculari.png";
			images["SpecularSac"] = "../resources/avatar/FEMALE/sacSpecular.png";
			
			m_avatarRS = new Dictionary;
			
			for(var i:uint= 1; i < 45; i++){
				if(i < 10)
					m_avatarRS[i-1] = "../resources/avatar/FEMALE/F_H_00"+i+"_Body.y3d";
				else
					m_avatarRS[i-1] = "../resources/avatar/FEMALE/F_H_0"+i+"_Body.y3d";
			}
			m_avatarRS[44] = "../resources/avatar/FEMALE/F_H_Face.y3d";
			m_avatarRS[45] = "../resources/avatar/FEMALE/F_H_Scalp.y3d";
			m_avatarRS[46] = "../resources/avatar/FEMALE/F_H_Sac_001.y3d";
			
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
			
			for(key in m_avatarRS){
				m_loader.add(m_avatarRS[key], DataLoader, Y3D_Parser, {dataFormat: URLLoaderDataFormat.BINARY}  );
			}
			//			m_loader.add(m_alphaliPath, DataLoader, Y3D_Parser, {dataFormat: URLLoaderDataFormat.BINARY}  );
			//		//	m_loader.add(m_manPath, DataLoader, Y3D_Parser, {dataFormat: URLLoaderDataFormat.BINARY}  );
			m_loader.add( "../resources/avatar/animation/f_run_001.yoa", DataLoader, YOA_Parser, {dataFormat: URLLoaderDataFormat.BINARY} );
			m_loader.add( "../resources/avatar/animation/f_idle_001.yoa", DataLoader, YOA_Parser, {dataFormat: URLLoaderDataFormat.BINARY} );
			m_loader.add( "../resources/avatar/animation/f_sitting_001.yoa", DataLoader, YOA_Parser, {dataFormat: URLLoaderDataFormat.BINARY} );
			m_loader.add( "../resources/avatar/animation/f_walk_001.yoa", DataLoader, YOA_Parser, {dataFormat: URLLoaderDataFormat.BINARY} );

			
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
					sceneObjs[key].material = new MaterialYogurtistanLocationV2(UIManagerV2.DIFFUSE_GRADIENT,UIManagerV2.AMB_UP, UIManagerV2.AMB_DOWN);
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
					sceneObjs[obj.key].material = new MaterialYogurtistanLocationV2(UIManagerV2.DIFFUSE_GRADIENT, UIManagerV2.AMB_UP, UIManagerV2.AMB_DOWN);
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
		
		public function getMap(_key:String):TextureMap{
			
			return m_loader.getLoadedContent(images[_key]);
		}
		public var m_avatar:SceneObjectContainer = null;
		
		public override function get avatar():SceneObjectContainer{
			if(m_avatar == null)
				createAvatar();
			return m_avatar;
		}
		private function onObjSelected(event:MouseEvent3D):void{
			
			trace((event.currentTarget3d as SceneObjectRenderable).systemID, "is double clicked");
			
		}
		
		public function createAvatar():SceneObjectContainer{
			m_avatar = new SceneObjectContainer;
			
			var obj:SceneObjectRenderable;
			for(var key:Object in m_avatarRS){
				obj = new SceneObjectRenderable;
				obj.geometry = m_loader.getLoadedContent(m_avatarRS[key]);
	//			obj.material = new MaterialFill(0xFFFFFF);
				if(key == 46)
					obj.material = new MaterialYogurtistanAvatar(UIManagerV2.GRADIENT_AVATAR,  null, getMap("FemaleSac"));
				else if(key != 44 && key != 45)
					obj.material = new MaterialYogurtistanAvatar(UIManagerV2.GRADIENT_AVATAR,  null, getMap("FemaleBody"));
				else
					obj.material = new MaterialYogurtistanAvatar(UIManagerV2.GRADIENT_AVATAR,  null, getMap("FemaleSurat"));
				obj.interactive = true;
				obj.pickEnabled = true;
				obj.onMouseDoubleClick.add(onObjSelected);
				
				m_avatar.addChild(obj);
				
				SkinController(SkeletalAnimatedMesh(obj.geometry).controller).addAnimation("RUN", m_loader.getLoadedContent( "../resources/avatar/animation/f_run_001.yoa"));
				SkinController(SkeletalAnimatedMesh(obj.geometry).controller).addAnimation("IDLE", m_loader.getLoadedContent( "../resources/avatar/animation/f_idle_001.yoa"));
				SkinController(SkeletalAnimatedMesh(obj.geometry).controller).addAnimation("SITTING", m_loader.getLoadedContent( "../resources/avatar/animation/f_sitting_001.yoa"));
				SkinController(SkeletalAnimatedMesh(obj.geometry).controller).addAnimation("WALK", m_loader.getLoadedContent( "../resources/avatar/animation/f_walk_001.yoa"));
				
				SkinController(SkeletalAnimatedMesh(obj.geometry).controller).playAnimation("IDLE");
				
			}
			
			return m_avatar;
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