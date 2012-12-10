package managers
{
	import com.yogurt3d.core.animation.controllers.SkinController;
	import com.yogurt3d.core.geoms.SkeletalAnimatedMesh;
	import com.yogurt3d.core.sceneobjects.SceneObjectContainer;
	import com.yogurt3d.core.sceneobjects.SceneObjectRenderable;
	import com.yogurt3d.core.sceneobjects.SkyBox;
	import com.yogurt3d.core.sceneobjects.event.MouseEvent3D;
	import com.yogurt3d.core.setup.SetupBase;
	import com.yogurt3d.core.texture.TextureMap;
	import com.yogurt3d.io.loaders.DataLoader;
	import com.yogurt3d.io.loaders.DisplayObjectLoader;
	import com.yogurt3d.io.managers.loadmanagers.LoadManager;
	import com.yogurt3d.io.parsers.TextureMap_Parser;
	import com.yogurt3d.io.parsers.Y3D_Parser;
	import com.yogurt3d.io.parsers.YOA_Parser;
	import com.yogurt3d.presets.material.yogurtistan.MaterialYogurtistanAvatar;
	
	import flash.net.URLLoaderDataFormat;
	import flash.utils.Dictionary;
	
//	import skybox.Desert2SkyBox;

	
	public class ResourceManager extends Manager
	{
		private var m_loader					:LoadManager;
		private var m_imageDict					:Dictionary;
		private var m_materials					:Dictionary;
			
		private var m_obj						:String;
		private var m_headPath					:String;
		private var m_alphaliPath				:String;
		private var m_manPath					:String;
		private var m_spherePath				:String;
		private var m_planePath					:String;
		private var m_boxPath					:String;
		private var m_avatarPath				:String;
		
		private var m_skyBox					:SkyBox;
		private var m_plane						:SceneObjectRenderable;
		private var m_sceneObject				:SceneObjectRenderable;
		private var m_head						:SceneObjectRenderable;
		private var m_man						:SceneObjectRenderable;
		private var m_box						:SceneObjectRenderable;
		private var m_meydan					:SceneObjectRenderable;
		private var m_setup						:SetupBase;
		private var m_sphere					:SceneObjectRenderable;
	
		private var m_avatar					:SceneObjectContainer;
	
		private var m_avatarRS					:Dictionary;
		
		public function ResourceManager(_setup:SetupBase)
		{
			m_setup = _setup;
			m_imageDict = new Dictionary();
			m_materials = new Dictionary();
			
			m_avatarRS = new Dictionary;
			
			for(var i:uint= 1; i < 45; i++){
				if(i < 10)
					m_avatarRS[i-1] = "../resources/avatar/FEMALE/F_H_00"+i+"_Body.y3d";
				else
					m_avatarRS[i-1] = "../resources/avatar/FEMALE/F_H_0"+i+"_Body.y3d";
			}
			m_avatarRS[44] = "../resources/avatar/FEMALE/F_H_Face.y3d";
			m_avatarRS[45] = "../resources/avatar/FEMALE/F_H_Scalp.y3d";
			
			m_headPath = "../resources/head/Head.y3d";
		//	m_manPath = "../resources/man/Man_animated.y3d";
//			m_spherePath = "../resources/y3d/mat.y3d";
			m_avatarPath = "../resources/avatar/Erkek_Avatar_HP.y3d";
//			m_alphaliPath = "../resources/Kagithane/Alfali_Urunler.y3d";
			
			m_imageDict["colorMapHead"] = "../resources/head/Head-Color.jpg";
			m_imageDict["normalMapHead"] = "../resources/head/Head-Normal.jpg";
			m_imageDict["specularMapHead"] = "../resources/head/Head-Spec.jpg";
			
			m_imageDict["FemaleBody"] = "../resources/avatar/FEMALE/Govde.png";
			m_imageDict["FemaleSurat"] = "../resources/avatar/FEMALE/Surat_yeni.png";
			
//			m_imageDict["normal"] = "../resources/set/mat_normal_1.jpg";
//			m_imageDict["color"] = "../resources/set/checkercolor.gif";
//			m_imageDict["spec"] = "../resources/set/spec.jpg";
			
			
//			m_imageDict["alphali"] = "../resources/Kagithane/Alfali_Urunler.png";
//			m_imageDict["lightMap"] = "../resources/Kagithane/Alfali_Urunler_LM.jpg";
//			m_imageDict["sphereMap"] = "../resources/spheremap.jpg";
			
//			m_imageDict["colorMapMan"] = "../resources/man/Man.png";
//			m_imageDict["normalMapMan"] = "../resources/man/Man_nml.png";
//			m_imageDict["specularMapMan"] = "../resources/man/Man_spm.png";
			
			m_imageDict["difGradient"] = "../resources/Diffuse_Gradient.png";
			m_imageDict["ambGradient"] = "../resources/Ambient_Gradient.png";
//			
			m_imageDict["colorMapAvatar"] = "../resources/avatar/Vucud.png";
			m_imageDict["specularMapAvatar"] = "../resources/man/Man_spm.png";
			
//			m_imageDict["colorMapSphere"] = "../resources/y3d/mat_color_1.png";
//			m_imageDict["normalMapSphere"] = "../resources/y3d/mat_normal_1.jpg";
//			m_imageDict["specularMapSphere"] = "../resources/y3d/mat_spec_grayscale.png";
			
//			m_imageDict["sp1"] = "../resources/sp1.png";
//			m_imageDict["sp2"] = "../resources/sp2.png";
			
		//	m_skyBox = new Desert2SkyBox;
		//	m_planePath = "../resources/AO_grid.y3d";
		//	m_boxPath = "../resources/AO_cube.y3d";
		
		}
	
		public function loadResources():void{
			
			m_loader = new LoadManager();
			
			for (var key:Object in m_imageDict) {
				if(String(m_imageDict[key]).indexOf(".atf") != -1){
					m_loader.add( m_imageDict[key], DataLoader, TextureMap_Parser, {dataFormat: URLLoaderDataFormat.BINARY}  );
				}else{
					m_loader.add( m_imageDict[key], DisplayObjectLoader, TextureMap_Parser, null, true );
				}			
			}
			
		//	m_loader.add(m_obj, DataLoader, Y3D_Parser, {dataFormat: URLLoaderDataFormat.BINARY}  );
		//	m_loader.add(m_planePath, DataLoader, Y3D_Parser, {dataFormat: URLLoaderDataFormat.BINARY}  );
			m_loader.add(m_headPath, DataLoader, Y3D_Parser, {dataFormat: URLLoaderDataFormat.BINARY}  );
			m_loader.add(m_avatarPath, DataLoader, Y3D_Parser, {dataFormat: URLLoaderDataFormat.BINARY}  );
			
			for(var key:Object in m_avatarRS){
				m_loader.add(m_avatarRS[key], DataLoader, Y3D_Parser, {dataFormat: URLLoaderDataFormat.BINARY}  );
			}
//			m_loader.add(m_alphaliPath, DataLoader, Y3D_Parser, {dataFormat: URLLoaderDataFormat.BINARY}  );
//		//	m_loader.add(m_manPath, DataLoader, Y3D_Parser, {dataFormat: URLLoaderDataFormat.BINARY}  );
			m_loader.add( "../resources/avatar/animation/f_run_001.yoa", DataLoader, YOA_Parser, {dataFormat: URLLoaderDataFormat.BINARY} );
			//m_loader.add( "../resources/avatar/animation/f_pointing_001.yoa", DataLoader, YOA_Parser, {dataFormat: URLLoaderDataFormat.BINARY} );
			//m_loader.add( "../resources/avatar/animation/f_sitting_001.yoa", DataLoader, YOA_Parser, {dataFormat: URLLoaderDataFormat.BINARY} );
			//m_loader.add( "../resources/avatar/animation/f_walk_001.yoa", DataLoader, YOA_Parser, {dataFormat: URLLoaderDataFormat.BINARY} );

		}
		

		public function get skybox():SkyBox{
			return m_skyBox;
		}
		
		public function get loader():LoadManager
		{
			return m_loader;
		}
		
		public function set loader(value:LoadManager):void
		{
			m_loader = value;
		}
		
		public function getMap(_key:String):TextureMap{
			
			return m_loader.getLoadedContent(m_imageDict[_key]);
		}
		
		public function getCube():SceneObjectRenderable{
			
			m_box 			= new SceneObjectRenderable();
			m_box.geometry = m_loader.getLoadedContent(m_boxPath);
			m_box.transformation.rotationY = 180;
			
			return m_box;
		}
		
		public function getMan():SceneObjectRenderable{
			
			m_man 			= new SceneObjectRenderable();
			m_man.geometry = m_loader.getLoadedContent(m_manPath);
			SkinController(SkeletalAnimatedMesh(m_man.geometry).controller).addAnimation("walk",m_loader.getLoadedContent( "../resources/man/Yurume.yoa"));
			//m_man.transformation.rotationY = 180;
			
			return m_man;
		}
		
		public function getAlphali():SceneObjectRenderable{
			var m_tmp:SceneObjectRenderable = new SceneObjectRenderable;
			m_tmp.geometry = m_loader.getLoadedContent(m_alphaliPath);	
			m_tmp.transformation.scale = 4;
			m_tmp.transformation.z = 80;
			//SkinController(SkeletalAnimatedMesh(m_avatar.geometry).controller).addAnimation("walk",m_loader.getLoadedContent( "../resources/avatar/m_walk_001.yoa"));
			return m_tmp;
		}
		
		private function onObjSelected(event:MouseEvent3D):void{
			
			trace((event.currentTarget3d as SceneObjectRenderable).systemID, "is double clicked");
	
		}
		
		public function getAvatar():SceneObjectContainer{
			var cont:SceneObjectContainer = new SceneObjectContainer;
			var obj:SceneObjectRenderable;
			for(var key:Object in m_avatarRS){
				obj = new SceneObjectRenderable;
				obj.geometry = m_loader.getLoadedContent(m_avatarRS[key]);
				if(key != 44 && key != 45)
					obj.material = new MaterialYogurtistanAvatar(UIManager.GRADIENT,  null, getMap("FemaleBody"));
				else
					obj.material = new MaterialYogurtistanAvatar(UIManager.GRADIENT,  null, getMap("FemaleSurat"));
				obj.interactive = true;
				obj.pickEnabled = true;
				obj.onMouseDoubleClick.add(onObjSelected);
				
				cont.addChild(obj);
				
				SkinController(SkeletalAnimatedMesh(obj.geometry).controller).addAnimation("RUN",m_loader.getLoadedContent( "../resources/avatar/animation/f_run_001.yoa"));
				SkinController(SkeletalAnimatedMesh(obj.geometry).controller).playAnimation("RUN");
				//m_loader.add(m_avatarRS[key], DataLoader, Y3D_Parser, {dataFormat: URLLoaderDataFormat.BINARY}  );
			}

			return cont;
		}
		
		public function getHead():SceneObjectRenderable{
		
			m_head 			= new SceneObjectRenderable();
			m_head.geometry = m_loader.getLoadedContent(m_headPath);
			m_head.transformation.scale = 20;
//			m_head.transformation.x = -110;
			m_head.transformation.y = 23;
			//m_head.transformation.rotationY = 180;
			
			return m_head;
		}
		
		public function getPlane():SceneObjectRenderable{
			m_plane = new SceneObjectRenderable();
			m_plane.geometry 	= m_loader.getLoadedContent(m_planePath);
	//		m_plane.material = new MaterialFill(0x00FF00);

			return m_plane;
		}
		
		public function getObject():SceneObjectRenderable{
			m_sceneObject = new SceneObjectRenderable();
			m_sceneObject.geometry 	= m_loader.getLoadedContent(m_obj)	
			return m_sceneObject;
		}
			
	}
}