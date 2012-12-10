package 
{
	import com.yogurt3d.core.lights.ELightType;
	import com.yogurt3d.core.lights.RenderableLight;
	import com.yogurt3d.core.utils.Color;
	import com.yogurt3d.debug.stats.Stats;
	import com.yogurt3d.io.managers.loadmanagers.LoadManager;
	import com.yogurt3d.io.managers.loadmanagers.LoaderEvent;
	
	import flash.display.Sprite;
	
	import managers.LocationLoader;
	import managers.UIManager;
	
	import setup.TestSetup;
	
	[SWF(width="1200", height="700", frameRate="60")]
	public class TestLocation extends Sprite
	{
		private var setup:TestSetup;		
		private var rMan:LocationLoader;
		private var loader:LoadManager;
		
		private var light1:RenderableLight;	
		
		private var uiMan:UIManager;
		
		public function TestLocation()
		{
			
			setup = new TestSetup(this);
			
			TestSetup(setup).scene.sceneColor.r = .6;
			TestSetup(setup).scene.sceneColor.g = .6;
			TestSetup(setup).scene.sceneColor.b = .6;
			TestSetup(setup).scene.sceneColor.a = 1.0;
			
			TestSetup(setup).camera.transformation.z = 250;
			TestSetup(setup).camera.transformation.y = 150;
			TestSetup(setup).camera.transformation.x = -120;
			TestSetup(setup).camera.transformation.rotationX = -30;
			TestSetup(setup).camera.transformation.rotationY = -30;
			
			TestSetup(setup).viewport.pickingEnabled = true;
				
			rMan = new LocationLoader(setup);
			rMan.loadResources();
			loader = rMan.loader;
			
			uiMan = new UIManager(rMan, this, setup);
			
			loader.addEventListener( LoaderEvent.ALL_COMPLETE, function( _e:LoaderEvent ):void
			{
				TestSetup(setup).scene.addChild(rMan.container);
				
				light1 = new RenderableLight(ELightType.DIRECTIONAL, Color.WHITE, 1);
				
				light1.transformation.x = 0;
				light1.transformation.y = 150;
				light1.transformation.z = -100;
				light1.transformation.rotationY = 0;
				light1.transformation.rotationX = -68;
				

				light1.color = Color.toRGB(0xAE0000);
			
				TestSetup(setup).scene.addChild( light1 );
				
				uiMan.createLightUI(light1, 0, 0);	
				uiMan.createLocationUI(1000, 0);
				uiMan.createPostEffectUI( 0, 220, 0, 245);
				
			//	uiMan.createGradient(0, 450);
			});
			
			loader.start();
			
			var stats:Stats = new Stats(TestSetup(setup).viewport);
			stats.x = 1130;
			stats.y = 600;
			
			this.addChild(stats);
		}
			
	}
}