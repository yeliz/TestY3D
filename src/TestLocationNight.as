package
{
	import com.yogurt3d.core.lights.ELightType;
	import com.yogurt3d.core.lights.RenderableLight;
	import com.yogurt3d.core.utils.Color;
	import com.yogurt3d.debug.stats.Stats;
	import com.yogurt3d.io.managers.loadmanagers.LoadManager;
	import com.yogurt3d.io.managers.loadmanagers.LoaderEvent;
	
	import flash.display.Sprite;
	
	import location.CanDemoMeydan;
	
	import managers.LocationLoaderNight;
	import managers.UIManager;
	
	import setup.TestSetup;

	[SWF(width="1200", height="700", frameRate="60")]
	public class TestLocationNight extends Sprite
	{
		
		private var setup:TestSetup;		
		private var rMan:LocationLoaderNight;
		private var loader:LoadManager;
		
		private var light1:RenderableLight;	
		
		private var uiMan:UIManager;
		
		public function TestLocationNight()
		{

			setup = new TestSetup(this);
			
			TestSetup(setup).scene.sceneColor.r = .0;
			TestSetup(setup).scene.sceneColor.g = .0;
			TestSetup(setup).scene.sceneColor.b = .0;
			TestSetup(setup).scene.sceneColor.a = 1.0;
			
			TestSetup(setup).camera.transformation.z = 250;
			TestSetup(setup).camera.transformation.y = 150;
			TestSetup(setup).camera.transformation.x = -120;
			TestSetup(setup).camera.transformation.rotationX = -30;
			TestSetup(setup).camera.transformation.rotationY = -30;
			
			TestSetup(setup).viewport.pickingEnabled = true;
			
			rMan = new LocationLoaderNight(setup);
			rMan.curLocation = new CanDemoMeydan();
			rMan.loadResources();
			loader = rMan.loader;
			
			uiMan = new UIManager(rMan, this, setup);
			
			loader.addEventListener( LoaderEvent.ALL_COMPLETE, function( _e:LoaderEvent ):void
			{
				TestSetup(setup).scene.addChild(rMan.createContainer);
				
				light1 = new RenderableLight(ELightType.DIRECTIONAL, Color.WHITE, 1);
				
				light1.transformation.x = 0;
				light1.transformation.y = 150;
				light1.transformation.z = -100;
				light1.transformation.rotationY = 0;
				light1.transformation.rotationX = -68;
				
				
				light1.color = Color.toRGB(0xFFFFFF);
				
				TestSetup(setup).scene.addChild( light1 );
				
				uiMan.loadLocationUI(0,0);
				uiMan.createLightUI(light1, 0, 50);	
				uiMan.createLocationUINight(975, 0);
				uiMan.createPostEffectUI( 0, 220, 0, 245);
				
				
				uiMan.createGradient(0, 500);
			});
			
			loader.start();
			
			var stats:Stats = new Stats(TestSetup(setup).viewport);
			stats.x = 1130;
			stats.y = 650;
			
			this.addChild(stats);
		}
	}
}