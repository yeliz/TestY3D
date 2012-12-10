package
{
	import com.bit101.components.ColorChooser;
	import com.bit101.components.ComboBox;
	import com.bit101.components.HSlider;
	import com.bit101.components.Label;
	import com.bit101.components.Style;
	import com.bit101.components.Window;
	import com.yogurt3d.core.lights.RenderableLight;
	import com.yogurt3d.core.sceneobjects.Scene3D;
	import com.yogurt3d.core.sceneobjects.SceneObjectRenderable;
	import com.yogurt3d.core.utils.Color;
	import com.yogurt3d.debug.stats.Stats;
	import com.yogurt3d.io.managers.loadmanagers.LoadManager;
	import com.yogurt3d.io.managers.loadmanagers.LoaderEvent;
	import com.yogurt3d.presets.material.MaterialDiffuseTexture;
	import com.yogurt3d.presets.sceneobjects.GeodesicSphereSceneObject;
	import com.yogurt3d.presets.setup.TargetSetup;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import managers.ResourceManager;
	
	[SWF(width="1200", height="700", frameRate="60")]
	public class TestY3D extends Sprite
	{
		private var setup:TargetSetup;
		private var m_selectedObj:SceneObjectRenderable;
		private var sphere:GeodesicSphereSceneObject;
		private var light1:RenderableLight;
		private var m_selectedLight:RenderableLight;
		private var loader:LoadManager;
		private var head:SceneObjectRenderable;
		
		private var rMan:ResourceManager;
		
		public function TestY3D()
		{
					
			setup = new TargetSetup(this);
			setup.scene = new Scene3D();
			
			setup.scene.sceneColor.r = 0.3;
			setup.scene.sceneColor.g = 0.3;
			setup.scene.sceneColor.b = 0.3;
			
			//TargetSetup(setup).scene.skyBox = new Desert2SkyBox();
			
			TargetSetup(setup).camera.frustum.setProjectionPerspective( 75, 1200/700, 1, 1000);
			setup.camera.dist = 100;
			
			rMan = new ResourceManager(setup);
			rMan.loadResources();
			loader = rMan.loader;
				
			loader.addEventListener( LoaderEvent.ALL_COMPLETE, function( _e:LoaderEvent ):void
			{
				//			var plane:PlaneSceneObject = new PlaneSceneObject(500, 500);
				//			plane.material = new MaterialFill(0xCCCCCC);
				//			plane.transformation.y = -35.0;
				//setup.scene.addChild( plane );
				
//				sphere = new  GeodesicSphereSceneObject(50,8);
//				sphere.transformation.x = 110;
//				sphere.transformation.y = 10;
//				sphere.material = new MaterialDiffuseFill(0xFFFFFF);
//				setup.scene.addChild( sphere );
//				m_selectedObj = sphere;
				
				head = rMan.getHead();
				head.material = new MaterialDiffuseTexture(rMan.getMap("colorMapHead"));
			//	head.material = new MaterialYogurtistanLocation();
				setup.scene.addChild( head );
//				
//				light1 = new RenderableLight(ELightType.DIRECTIONAL, Color.WHITE, 1);
//				light1.transformation.x = 0;
//				light1.transformation.y = 150;
//				light1.transformation.z = -100;
//				light1.transformation.rotationY = 180;
//				light1.transformation.rotationX = -60;
//				
//				light1.color = Color.toRGB(0xAE0000);
//				m_selectedLight = light1;
//				setup.scene.addChild( light1 );
				
			//	setup.scene.postProcesses.add(new EffectDream());
				
			//	createUI();
			});
			
			loader.start();
			
			var stats:Stats = new Stats(TargetSetup(setup).viewport);
			stats.x = TargetSetup(setup).viewport.width - stats.WIDTH - 1;
			stats.y = TargetSetup(setup).viewport.height - stats.HEIGHT - 1;
			
			this.addChild(stats);

		
		}
		
		private function createUI():void{
			Style.setStyle( Style.DARK);
			var mainWindow:Window = new Window(parent, 0, 0, "Parameters");
			mainWindow.width = 200;
			mainWindow.height = 600;
			
			var objects:ComboBox = new ComboBox(mainWindow, 5, 10, "Sphere");
			objects.selectedIndex = 0;
			
//			objects.addItem("Man");	
//			objects.addItem("Head");
//			objects.addItem("Plane");
			objects.addItem("Sphere");
			objects.addItem("Head");
			
			objects.addEventListener(Event.SELECT, function():void{
				
				if(objects.selectedIndex == 0)
					m_selectedObj = sphere;
//					m_selectedObj = man;
				else if(objects.selectedIndex == 1)
					m_selectedObj = head;
//				else if(objects.selectedIndex == 2)
//					m_selectedObj = plane;
//				else if(objects.selectedIndex == 3)
					
				//				else
				//					m_selectedObj = sphere;
				//				
			//	colorChooserAmb.value = m_selectedObj.material.ambientColor.toUint();
			//	colorChooserEms.value = m_selectedObj.material.emissiveColor.toUint();
			//	colorChooserDif.value = m_selectedObj.material.diffuseColor.toUint();
			});
			
			var lab:Label = new Label(mainWindow, 5,  40, "Ambient Color:");
			var colorChooserAmb:ColorChooser = new ColorChooser( mainWindow, lab.width + 20, lab.y, m_selectedObj.material.ambientColor.toUint(), function():void{
				
				var color:Color = new Color(0,0,0);
				color.setColorUint(colorChooserAmb.value);
				m_selectedObj.material.ambientColor = color;
				
			});
			colorChooserAmb.usePopup = true;
			colorChooserAmb.useHandCursor = true;
//			
			lab = new Label(mainWindow, 5,  70, "Emmisive Color:");
			var colorChooserEms:ColorChooser = new ColorChooser( mainWindow, lab.width + 20, lab.y, m_selectedObj.material.emissiveColor.toUint(), function():void{
				var color:Color = new Color(0,0,0);
				color.setColorUint(colorChooserEms.value);
				m_selectedObj.material.emissiveColor = color;
			});
			colorChooserEms.usePopup = true;
			colorChooserEms.useHandCursor = true;
			
			
			if(light1){
				lab = new Label(mainWindow, 5,  180, "Directional Color:");
				var colorChooser1:ColorChooser = new ColorChooser( mainWindow, lab.width + 20, lab.y, light1.color.toUint(), function():void{
					
					var color:uint = colorChooser1.value;
					var m_color:Vector.<Number> = new Vector.<Number>;
					m_color[0] = (color >> 16 & 255 ) / 255;
					m_color[1] = (color >> 8 & 255) / 255;
					m_color[2] = (color & 255) / 255;
					
					light1.color = new Color(m_color[0], m_color[1], m_color[2]);
					
				});	
				colorChooser1.usePopup = true;
				colorChooser1.useHandCursor = true;
			}
			
			var lights:ComboBox = new ComboBox(mainWindow, 5, 270, "Directional");
			lights.selectedIndex = 0;
			
			lights.addItem("Directional");
			lights.addItem("Spot");
			lights.addItem("Point");
			
			lights.addEventListener(Event.SELECT, function():void{
				
				if(lights.selectedIndex == 0)
					m_selectedLight = light1;
//				else if(lights.selectedIndex == 1)
//					m_selectedLight = light2;
//				else
//					m_selectedLight = light3;
				
				dirX.value = m_selectedLight.transformation.rotationX;
				dirY.value = m_selectedLight.transformation.rotationY;
				dirZ.value = m_selectedLight.transformation.rotationZ;
				
				posX.value = m_selectedLight.transformation.x;
				posY.value = m_selectedLight.transformation.y;
				posZ.value = m_selectedLight.transformation.z;
				
				attX.value = m_selectedLight.attenuation[0];
				attY.value = m_selectedLight.attenuation[1];
				attZ.value = m_selectedLight.attenuation[2];
			});
			
			lab = new Label(mainWindow, 5,  300, "Rotation:");
			
			var dirX:HSlider = new HSlider(mainWindow,5, lab.y + 15, function():void{
				
				m_selectedLight.transformation.rotationX = dirX.value;
				//	m_selectedLight.
			});
			
			dirX.minimum = -360;
			dirX.maximum = 360;
			dirX.value = m_selectedLight.transformation.rotationX;
			
			var dirY:HSlider = new HSlider(mainWindow,5, lab.y + 35, function():void{
				
				m_selectedLight.transformation.rotationY = dirY.value;
				//	m_selectedLight.
			});
			
			dirY.minimum = -360;
			dirY.maximum = 360;
			dirY.value = m_selectedLight.transformation.rotationY;
			
			var dirZ:HSlider = new HSlider(mainWindow,5, lab.y + 55, function():void{
				
				m_selectedLight.transformation.rotationZ = dirZ.value;
				//	m_selectedLight.
			});
			
			dirZ.minimum = -360;
			dirZ.maximum = 360;
			dirZ.value = m_selectedLight.transformation.rotationZ;
			
			lab = new Label(mainWindow, 5,  370, "Position:");
			
			var posX:HSlider = new HSlider(mainWindow,5, lab.y + 15, function():void{
				
				m_selectedLight.transformation.x = posX.value;
				//	m_selectedLight.
			});
			
			posX.minimum = -360;
			posX.maximum = 360;
			posX.value = m_selectedLight.transformation.x;
			posX.tick = 0.1;
			
			var posY:HSlider = new HSlider(mainWindow,5, lab.y + 35, function():void{
				
				m_selectedLight.transformation.y = posY.value;
				
			});
			
			posY.minimum = -360;
			posY.maximum = 360;
			posY.value = m_selectedLight.transformation.y;
			posY.tick = 0.1;
			
			var posZ:HSlider = new HSlider(mainWindow,5, lab.y + 55, function():void{
				
				m_selectedLight.transformation.z = posZ.value;
				//	m_selectedLight.
			});
			
			posZ.minimum = -360;
			posZ.maximum = 360;
			posZ.value = m_selectedLight.transformation.z;
			posZ.tick = 0.1;
			
			lab = new Label(mainWindow, 5,  440, "Att:");
			
			var attX:HSlider = new HSlider(mainWindow,5, lab.y + 15, function():void{
				
				m_selectedLight.attenuation[0] = attX.value;
				//	m_selectedLight.
			});
			attX.minimum = 0;
			attX.maximum = 5;
			attX.value = m_selectedLight.attenuation[0];
			attX.tick = 0.1;
			
			var attY:HSlider = new HSlider(mainWindow,5, lab.y + 35, function():void{
				
				m_selectedLight.attenuation[1] = attX.value;
				//	m_selectedLight.
			});
			attY.minimum = 0;
			attY.maximum = 5;
			attY.value = m_selectedLight.attenuation[1];
			attY.tick = 0.1;
			
			
			var attZ:HSlider = new HSlider(mainWindow,5, lab.y + 55, function():void{
				
				m_selectedLight.attenuation[2] = attY.value;
				//	m_selectedLight.
			});
			attZ.minimum = 0;
			attZ.maximum = 5;
			attZ.value = m_selectedLight.attenuation[2];
			attZ.tick = 0.1;
//			
//			lab = new Label(mainWindow, 5,  100, "Diffuse Color:");
//			var colorChooserDif:ColorChooser = new ColorChooser( mainWindow, lab.width + 20, lab.y, m_selectedObj.material.diffuseColor.toUint(), function():void{
//				m_selectedObj.material.diffuseColor.setColorUint(colorChooserDif.value);
//			});
//			colorChooserDif.usePopup = true;
//			colorChooserDif.useHandCursor = true;
			
//			lab = new Label(mainWindow, 5,  140, "Specular Color:");
//			var colorChooserSpec:ColorChooser = new ColorChooser( mainWindow, lab.width + 20, lab.y, m_selectedObj.subShader.specularColor.toUint(), function():void{
//				m_selectedObj.material.specularColor.setColorUint(colorChooserSpec.value);
//			});
//			colorChooserSpec.usePopup = true;
//			colorChooserSpec.useHandCursor = true;
		}
	}
}