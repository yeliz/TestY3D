package
{
	import com.yogurt3d.core.animation.controllers.SkinController;
	import com.yogurt3d.core.geoms.SkeletalAnimatedMesh;
	import com.yogurt3d.core.lights.ELightType;
	import com.yogurt3d.core.lights.RenderableLight;
	import com.yogurt3d.core.sceneobjects.SceneObjectContainer;
	import com.yogurt3d.core.sceneobjects.SceneObjectRenderable;
	import com.yogurt3d.core.utils.Color;
	import com.yogurt3d.debug.stats.Stats;
	import com.yogurt3d.io.managers.loadmanagers.LoadManager;
	import com.yogurt3d.io.managers.loadmanagers.LoaderEvent;
	import com.yogurt3d.presets.material.yogurtistan.MaterialYogurtistanAvatar;
	
	import flash.display.Sprite;
	
	import managers.ResourceManager;
	import managers.UIManager;
	
	import setup.TestSetup;
	
	[SWF(width="1200", height="700", frameRate="60")]
	public class YAvatarShader extends Sprite
	{
		private var setup:TestSetup;		
		private var rMan:ResourceManager;
		private var loader:LoadManager;
		
		private var light1:RenderableLight;
		
		private var m_selectedObj:SceneObjectRenderable;
		private var m_avatar:SceneObjectContainer;
		
		private var uiMan:UIManager;
		
		public function YAvatarShader()
		{
//			var stats:Stats = new Stats();
//			stats.x = 1130;
//			stats.y = 600;
//			
//			this.addChild(stats);
			setup = new TestSetup(this);
			
			TestSetup(setup).scene.sceneColor.r = 0.0;
			TestSetup(setup).scene.sceneColor.g = 0.0;
			TestSetup(setup).scene.sceneColor.b = 0.0;
			TestSetup(setup).scene.sceneColor.a = 1.0;
			
			TestSetup(setup).camera.transformation.z = 20;
			TestSetup(setup).camera.transformation.y = 20;
//			TestSetup(setup).camera.transformation.x = -120;
			TestSetup(setup).camera.transformation.rotationX = -20;
//			TestSetup(setup).camera.transformation.rotationY = -30;
			
			
//			TargetCamera(setup.camera).dist = 40;
//			TargetCamera(setup.camera).rotX = -40;
		
			rMan = new ResourceManager(setup);
			rMan.loadResources();
			loader = rMan.loader;
			
			uiMan = new UIManager(rMan, this, setup);
			
			loader.addEventListener( LoaderEvent.ALL_COMPLETE, function( _e:LoaderEvent ):void
			{
				
				m_avatar = rMan.getAvatar();
		//		m_avatar.material = new MaterialYogurtistanAvatar(UIManager.GRADIENT,  null, rMan.getMap("colorMapAvatar"));
		//		SkinController(SkeletalAnimatedMesh(m_avatar.geometry).controller).playAnimation("walk");
				
				TestSetup(setup).scene.addChild(m_avatar);
				TestSetup(setup).viewport.pickingEnabled = true;
		//		m_selectedObj = m_avatar;
				
				light1 = new RenderableLight(ELightType.DIRECTIONAL, Color.WHITE, 1);
				light1.transformation.x = 0;
				light1.transformation.y = 150;
				light1.transformation.z = -100;
				light1.transformation.rotationY = 0;
				light1.transformation.rotationX = -60;
//				
//				light1.color.r = 0.752;
//				light1.color.g = 0.662;
//				light1.color.b = 0.517;
				light1.color = Color.toRGB(0xFFFFFF);
				TestSetup(setup).scene.addChild( light1 );

				uiMan.createLightUI(light1, 0, 0);	
				uiMan.createAvatarUI(1000, 0 , m_avatar);
				uiMan.createGradient(0, 450);
				//createUI();
			});
			
			loader.start();
			
			var stats:Stats = new Stats(TestSetup(setup).viewport);
			stats.x = TestSetup(setup).viewport.width - stats.WIDTH - 1;
			stats.y = TestSetup(setup).viewport.height - stats.HEIGHT - 1;
			
			this.addChild(stats);
			
		}
	
	}
}