package debug
{
	import com.bit101.components.CheckBox;
	import com.bit101.components.ColorChooser;
	import com.bit101.components.ComboBox;
	import com.bit101.components.Component;
	import com.bit101.components.HSlider;
	import com.bit101.components.Label;
	import com.bit101.components.NumericStepper;
	import com.bit101.components.Panel;
	import com.bit101.components.PushButton;
	import com.bit101.components.Style;
	import com.bit101.components.Window;
	import com.yogurt3d.core.animation.controllers.SkinController;
	import com.yogurt3d.core.geoms.SkeletalAnimatedMesh;
	import com.yogurt3d.core.lights.Light;
	import com.yogurt3d.core.render.post.PostProcessingEffectBase;
	import com.yogurt3d.core.sceneobjects.SceneObjectContainer;
	import com.yogurt3d.core.sceneobjects.SceneObjectRenderable;
	import com.yogurt3d.core.sceneobjects.event.MouseEvent3D;
	import com.yogurt3d.core.texture.TextureMap;
	import com.yogurt3d.core.utils.Color;
	import com.yogurt3d.core.utils.TextureMapDefaults;
	import com.yogurt3d.io.managers.loadmanagers.LoaderEvent;
	import com.yogurt3d.presets.effects.EffectBrightnessContrast;
	import com.yogurt3d.presets.effects.EffectColorGrading;
	import com.yogurt3d.presets.effects.EffectDotScreen;
	import com.yogurt3d.presets.effects.EffectDream;
	import com.yogurt3d.presets.effects.EffectEmboss;
	import com.yogurt3d.presets.effects.EffectGammaCorChannel;
	import com.yogurt3d.presets.effects.EffectGammaCorrection;
	import com.yogurt3d.presets.effects.EffectGreyScale;
	import com.yogurt3d.presets.effects.EffectHueSaturation;
	import com.yogurt3d.presets.effects.EffectLaplacian;
	import com.yogurt3d.presets.effects.EffectLensCircle;
	import com.yogurt3d.presets.effects.EffectNegative;
	import com.yogurt3d.presets.effects.EffectNightVision;
	import com.yogurt3d.presets.effects.EffectNoise;
	import com.yogurt3d.presets.effects.EffectPixelation;
	import com.yogurt3d.presets.effects.EffectPosterization;
	import com.yogurt3d.presets.effects.EffectRadialBlur;
	import com.yogurt3d.presets.effects.EffectScrathedFilm;
	import com.yogurt3d.presets.effects.EffectSephia;
	import com.yogurt3d.presets.effects.EffectSharpen;
	import com.yogurt3d.presets.effects.EffectSwirl;
	import com.yogurt3d.presets.effects.EffectThermalVision;
	import com.yogurt3d.presets.effects.EffectVibrance;
	import com.yogurt3d.presets.material.yogurtistan.MaterialYogurtistanAvatar;
	import com.yogurt3d.presets.material.yogurtistanv2.MaterialYogurtistanLocationV2;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.utils.Dictionary;
	
	import location.CanDemoMeydan;
	import location.CanMeydan;
	import location.Kagithane;
	import location.Luxuria;
	import location.NumanMeydan;
	import location.SimpleLife;
	
	import managers.Manager;
	
	import setup.TestSetup;
	
	import skybox.Desert2SkyBox;
	import skybox.NightSkyBox;
	import skybox.VasaSkyBox;
	
	
	public class UIManagerV2
	{
		private var m_rMan:Manager;
		private var m_parent:DisplayObjectContainer;
		private var m_setup:TestSetup;
		public  var outside:Desert2SkyBox = new Desert2SkyBox();
		public  var night:NightSkyBox = new NightSkyBox();
		public  var vasa:VasaSkyBox = new VasaSkyBox();
		
		public function UIManagerV2(_rMan:Manager, _parent:DisplayObjectContainer, _setup:TestSetup)
		{
			m_rMan = _rMan;
			m_parent = _parent;
			m_setup = _setup;
		}
		
		/*******************************************************************************************************
		 * LOCATIONS
		 * 
		 * ***************************************************************************************************/
		private var locationC:ComboBox;
		public function loadLocationUI(_posX:Number=0, _posY:Number=0):void{
			
			Style.setStyle( Style.DARK);
			var mainWindow:Window = new Window(m_parent, _posX, _posY, "Locations");
			mainWindow.width = 200;
			mainWindow.height = 50;
			
			locationC = new ComboBox(mainWindow, 5, 10, "None");
			locationC.addItem("CanMeydan");
			locationC.addItem("Kagithane");
			locationC.addItem("Luxuria");
			locationC.addItem("NumanMeydan");
			locationC.addItem("SimpleLife");
			locationC.addItem("CanDemoMeydan");
			
			locationC.addEventListener(Event.SELECT, function():void{
				
				if(locationC.selectedItem  == "SimpleLife"){
					(m_rMan as LocationLoaderV2).curLocation = new SimpleLife();
				}else if(locationC.selectedItem  == "Luxuria"){
					(m_rMan as LocationLoaderV2).curLocation = new Luxuria();
				}else if(locationC.selectedItem  == "CanMeydan"){
					(m_rMan as LocationLoaderV2).curLocation = new CanMeydan();
				}else if(locationC.selectedItem  == "NumanMeydan"){
					(m_rMan as LocationLoaderV2).curLocation = new NumanMeydan();
				}else if(locationC.selectedItem  == "Kagithane"){
					(m_rMan as LocationLoaderV2).curLocation = new Kagithane();
				}else if(locationC.selectedItem  == "CanDemoMeydan"){
					(m_rMan as LocationLoaderV2).curLocation = new CanDemoMeydan();
				}
				
			//	TestSetup(m_setup).scene.removeChild((m_rMan as LocationLoaderV2).container);
				
				(m_rMan as LocationLoaderV2).loadResources();
				
				(m_rMan as LocationLoaderV2).loader.addEventListener( LoaderEvent.ALL_COMPLETE, function( _e:LoaderEvent ):void
				{
					TestSetup(m_setup).scene.addChild((m_rMan as LocationLoaderV2).createContainer);
				//	trace((m_rMan as LocationLoaderV2).createContainer.children.length);
					m_IdName = new Dictionary;
			
					var obj:SceneObjectRenderable;
					objects.removeAll();
					
					for (var key:Object in m_rMan.models) {
						objects.addItem(key);
						objects.selectedItem = key;
						
						obj = (m_rMan.sceneObjs[key] as SceneObjectRenderable);
						obj.onMouseDoubleClick.add(onObjSelected);
						m_IdName[obj.systemID] = key;
						
						m_selectedObj = m_rMan.sceneObjs[key];
					}
				
				});
				(m_rMan as LocationLoaderV2).loader.start();
			});
			
			//var loader:LoadManager = (m_rMan as LocationLoaderNight).loader;
		}

		
		/*******************************************************************************************************
		 * 
		 *  NIGHT UI
		 * 
		 * *****************************************************************************************************/
		
		private var opacitySlider:HSlider;
		private var refAlphaSlider:HSlider;
		private var colorChooserMat:ColorChooser;
		private var kSpecSlider:NumericStepper;
		private var fSpecPowerSlider:HSlider;
		private var kRimSlider:HSlider;
		private var fRimPowerSlider:HSlider;
		private var ksSlider:HSlider;
		private var krSlider:HSlider;
		private var emmisiveAlpha:HSlider;
		private var blendSlider:HSlider;
		private var fresnelPower:HSlider;
		private var reflectance:HSlider;
		private var specChooserMat:ColorChooser;
		private var opLabel:Label;
		private var refLabel:Label;
		private var powLabel:Label;
		private var freRefLabel:Label;
		private var ksColorLabel:Label;
		private var emmLabel:Label;
		private var krLabel:Label;
		private var krimLabel:Label;
		private var blendLabel:Label;
		private var spowLabel:Label;
		private var srimLabel:Label;
		
		private var cMap:CheckBox;
		private var sMap:CheckBox;
		private var eMap:CheckBox;
		private var sMask:CheckBox;
		private var lMap:CheckBox;
		private var refMapsC:ComboBox;
		private var m_saveToXML:PushButton;
		private var allMAterial:Window;
		
		public function createLocationUINight(_posX:Number=0, _posY:Number=0):void{
			Style.setStyle( Style.DARK);
			
			allMAterial = new Window(m_parent, _posX, _posY, "Material");
			allMAterial.width = 220;
			allMAterial.height = 600;
			allMAterial.enabled = false;
			
			// OPACITY
			var panel1:Panel = new Panel(allMAterial, 5, 5);
			panel1.width = 210;
			panel1.height = 20;
			panel1.color = 0x555555;
			var lab:Label  = new Label(panel1, 5,  0, "Opacity:");
			
			opacitySlider = new HSlider(panel1, lab.x+ lab.width + 8, lab.y + 4, function():void{
				MaterialYogurtistanLocationV2(m_selectedObj.material).opacity = opacitySlider.value;
				opLabel.text = ""+opacitySlider.value;
			});
			
			opacitySlider.minimum = 0;
			opacitySlider.maximum = 1;
			opacitySlider.tick = 0.1;
			opLabel  = new Label(panel1, opacitySlider.x+ opacitySlider.width + 8,  lab.y,""+opacitySlider.value);
			
			// REFLECTION
			
			var panel2:Panel = new Panel(allMAterial, 5, 30);
			panel2.width = 210;
			panel2.height = 110;
			panel2.color = 0x555555;
			
			lab  = new Label(panel2, 5,  0, "REFLECTION");
			refMapsC = new ComboBox(panel2, 5, 20, "None");
			refMapsC.addItem("None");
			refMapsC.addItem("Night");
			refMapsC.addItem("Vasa");
			refMapsC.addItem("Outside");
			
			refMapsC.addEventListener(Event.SELECT, function():void{
				if(refMapsC.selectedItem == "None")
					MaterialYogurtistanLocationV2(m_selectedObj.material).reflectionMap = null;
				else if(refMapsC.selectedItem == "Night"){
					MaterialYogurtistanLocationV2(m_selectedObj.material).reflectionMap = night.texture;
				}else if(refMapsC.selectedItem == "Vasa"){
					MaterialYogurtistanLocationV2(m_selectedObj.material).reflectionMap = vasa.texture;
				}else if(refMapsC.selectedItem == "Outside"){
					MaterialYogurtistanLocationV2(m_selectedObj.material).reflectionMap = outside.texture;
				}
			});
			
			lab  = new Label(panel2, 5,  45, "RefAlpha:");
			
			refAlphaSlider = new HSlider(panel2, lab.x+ lab.width + 8, lab.y + 4, function():void{
				MaterialYogurtistanLocationV2(m_selectedObj.material).reflectionAlpha = refAlphaSlider.value;
				refLabel.text = ""+refAlphaSlider.value;
			});
			
			refAlphaSlider.minimum = 0;
			refAlphaSlider.maximum = 1;
			refAlphaSlider.tick = 0.1;
			refLabel = new Label(panel2, refAlphaSlider.x+ refAlphaSlider.width + 8,  lab.y,""+refAlphaSlider.value);
			
			lab  = new Label(panel2, 5,  65, "FresPower:");
			fresnelPower = new HSlider(panel2, lab.x+ lab.width + 5, lab.y + 4, function():void{
				MaterialYogurtistanLocationV2(m_selectedObj.material).fresnelPower = fresnelPower.value;
				powLabel.text = ""+fresnelPower.value;
			});
			fresnelPower.minimum = 0;
			fresnelPower.maximum = 10;
			fresnelPower.tick = 1;
			powLabel = new Label(panel2, fresnelPower.x+ fresnelPower.width + 8,  lab.y,""+fresnelPower.value);
			
			lab  = new Label(panel2, 5,  85, "FresRef:");
			
			reflectance = new HSlider(panel2, lab.x+ lab.width + 5, lab.y + 4, function():void{
				MaterialYogurtistanLocationV2(m_selectedObj.material).fresnelReflectance = reflectance.value/100;
				freRefLabel.text = "" + reflectance.value/100;
			});
			reflectance.minimum = 0;
			reflectance.maximum = 100;
			reflectance.tick = 0.1;
			freRefLabel  = new Label(panel2, reflectance.x+ reflectance.width + 8,  lab.y,""+(reflectance.value/100));
			
			// COLOR
			var panel3:Panel = new Panel(allMAterial, 5, 150);
			panel3.width = 210;
			panel3.height = 45;
			panel3.color = 0x555555;
			
			lab  = new Label(panel3, 5,  0, "COLOR MAP");
			cMap = new CheckBox(panel3, 5, lab.y+23, "Color Map", function():void{
				if(cMap.selected && m_rMan.textures[objects.selectedItem])
					MaterialYogurtistanLocationV2(m_selectedObj.material).colorMap = m_rMan.getTexture(objects.selectedItem as String);
				else
					MaterialYogurtistanLocationV2(m_selectedObj.material).colorMap = null;
			});
		
			// SPECULAR MAP
			var panel4:Panel = new Panel(allMAterial, 5, 200);
			panel4.width = 210;
			panel4.height = 60;
			panel4.color = 0x555555;
			
			lab  = new Label(panel4, 5,  0, "SHINENESS");
			lab  = new Label(panel4, 5,  20, "shinenness:");
			
			kSpecSlider = new NumericStepper(panel4, lab.x+ lab.width + 5, lab.y + 4, function():void{
				MaterialYogurtistanLocationV2(m_selectedObj.material).shineness = kSpecSlider.value;
			});
			
			kSpecSlider.minimum = 0;
			kSpecSlider.maximum = 200;
			kSpecSlider.step = 0.1;
	
			// SPECULAR MASK
			var panel5:Panel = new Panel(allMAterial, 5, 270);
			panel5.width = 210;
			panel5.height = 63;
			panel5.color = 0x555555;
			
			lab  = new Label(panel5, 5,  0, "SPECULAR");
			lab  = new Label(panel5, 5,  20, "specular:");
			ksSlider = new HSlider(panel5, lab.x+ lab.width + 5, lab.y + 4, function():void{
				MaterialYogurtistanLocationV2(m_selectedObj.material).specular = ksSlider.value;
				ksColorLabel.text = ""+ksSlider.value;
			});
			ksSlider.minimum = 0;
			ksSlider.maximum = 1;
			ksSlider.tick = 0.1;
			ksColorLabel = new Label(panel5, ksSlider.x+ ksSlider.width + 8,  lab.y,""+ksSlider.value);
		
			sMask = new CheckBox(panel5, 5, 40, "Specular Map", function():void{
				if(sMask.selected && m_rMan.specMasks[objects.selectedItem])
					MaterialYogurtistanLocationV2(m_selectedObj.material).specularMap = m_rMan.getSpecularMask(objects.selectedItem as String);
				else
					MaterialYogurtistanLocationV2(m_selectedObj.material).specularMap = null;
			
				ksSlider.value = MaterialYogurtistanLocationV2(m_selectedObj.material).specular;
				ksColorLabel.text = ""+ksSlider.value;
			});
			
			lab  = new Label(allMAterial, sMask.width+20,  310, "SColor");
			specChooserMat = new ColorChooser( panel5, sMask.width+50, 40, 0xFFFFFF, function():void{
				
				var color:uint = specChooserMat.value;
				var m_color:Vector.<Number> = new Vector.<Number>;
				m_color[0] = (color >> 16 & 255 ) / 255;
				m_color[1] = (color >> 8 & 255) / 255;
				m_color[2] = (color & 255) / 255;
				
				MaterialYogurtistanLocationV2(m_selectedObj.material).specColor = new Color(m_color[0], m_color[1], m_color[2]);
			});
			specChooserMat.usePopup = true;
			specChooserMat.useHandCursor = true;
			
			// EMMISIVE
			var panel6:Panel = new Panel(allMAterial, 5, 340);
			panel6.width = 210;
			panel6.height = 63;
			panel6.color = 0x555555;
			
			lab  = new Label(panel6, 5, 0, "EMMISIVE & LIGHT MAP");		
			lab  = new Label(panel6, 5,  35, "Emm Alpha:");
			
			emmisiveAlpha = new HSlider(panel6, lab.x+ lab.width + 5, lab.y + 4, function():void{
				MaterialYogurtistanLocationV2(m_selectedObj.material).emmisiveAlpha = emmisiveAlpha.value;
				emmLabel.text = ""+emmisiveAlpha.value;
			});
			emmisiveAlpha.minimum = 0;
			emmisiveAlpha.maximum = 2;
			emmisiveAlpha.tick = 0.1;
			emmLabel = new Label(panel6, emmisiveAlpha.x+ emmisiveAlpha.width + 8,  lab.y,""+emmisiveAlpha.value);
			
			// OTHER
			var panel7:Panel = new Panel(allMAterial, 5, 410);
			panel7.width = 210;
			panel7.height = 130;
			panel7.color = 0x555555;
			lab  = new Label(panel7, 5, 0, "OTHER");
					
			lab  = new Label(panel7, 5,  20, "blendCnst:");
			blendSlider = new HSlider(panel7, lab.x+ lab.width + 5, lab.y+4, function():void{
				MaterialYogurtistanLocationV2(m_selectedObj.material).blendConstant = blendSlider.value;
				blendLabel.text = ""+blendSlider.value;
			});
			blendSlider.minimum = 0;
			blendSlider.maximum = 10;
			blendSlider.tick = 0.1;
			blendLabel = new Label(panel7, blendSlider.x+ blendSlider.width + 8,  lab.y,""+blendSlider.value);
				
			lMap = new CheckBox(panel6, 5, 20, "LightMap", function():void{
							
				if(lMap.selected && m_rMan.lightMaps[objects.selectedItem])
					MaterialYogurtistanLocationV2(m_selectedObj.material).lightMap = m_rMan.getLightMap(objects.selectedItem as String);
				else
					MaterialYogurtistanLocationV2(m_selectedObj.material).lightMap = null;
							
			});

		}
		
		private var objects:ComboBox;
		private var m_IdName:Dictionary;
		private var m_selectedObj:SceneObjectRenderable;
		
		private function onObjSelected(event:MouseEvent3D):void{
			
			var key:String = m_IdName[(event.currentTarget3d as SceneObjectRenderable).systemID];
		//	trace(key + " is selected");
			if(key){
				m_selectedObj = m_rMan.sceneObjs[key];
					
				var _event:Event = new Event(Event.SELECT);
				objects.selectedItem = key;
				objects.dispatchEvent(event);			
			}
			allMAterial.visible = true;
			locGradient.visible = true;
			avatarGradient.visible = false;
			m_avatarUI.visible = false;
		}
		
		private function onAvatarSelected(event:MouseEvent3D):void{
			
			var _event:Event = new Event(Event.SELECT);
			objects.selectedItem = "AVATAR";
			objects.dispatchEvent(event);
//			
//			allMAterial.visible = false;
//			locGradient.visible = false;
//			avatarGradient.visible = true;
//			m_avatarUI.visible = true;
		}
		
		/*******************************************************************************************************
		 * 
		 * AVATAR MATERIAL
		 * 
		 * *****************************************************************************************************/
		private var m_avatarUI:Window;
		public function createAvatarUI(_posX:Number=0, _posY:Number=0, _avatar:SceneObjectContainer=null):void{
			
			var opacitySlider:HSlider;
			var blendSlider:HSlider;
			var opLabel:Label;
			var blendLabel:Label;
			var freRefLabel:Label;
			var animations:ComboBox;
			
			m_avatarUI = new Window(m_parent, _posX, _posY, "Material");
			m_avatarUI.width = 200;
			m_avatarUI.height = 400;
			m_avatarUI.visible = false;
			
			var lab:Label  = new Label(m_avatarUI, 5,  5, "Opacity:");
			
			opacitySlider = new HSlider(m_avatarUI, lab.x+ lab.width + 5, lab.y + 4, function():void{
				
				var obj:SceneObjectRenderable;
				for(var i:uint=0; i < _avatar.children.length; i++){
					obj = _avatar.children[i];
					MaterialYogurtistanAvatar(obj.material).opacity = opacitySlider.value;	
				}
				opLabel.text = ""+opacitySlider.value;
			});
			
			opacitySlider.minimum = 0;
			opacitySlider.maximum = 1;
			opacitySlider.value = MaterialYogurtistanAvatar((_avatar.children[0] as SceneObjectRenderable).material).opacity ;
			opacitySlider.tick = 0.1;
			
			opLabel  = new Label(m_avatarUI, opacitySlider.x+ opacitySlider.width + 8,  lab.y,""+opacitySlider.value);
			
			lab  = new Label(m_avatarUI, 5,  30, "Blend const:");
			
			blendSlider = new HSlider(m_avatarUI, lab.x+ lab.width + 5, lab.y + 4, function():void{	
				var obj:SceneObjectRenderable;
				for(var i:uint=0; i < _avatar.children.length; i++){
					obj = _avatar.children[i];
					MaterialYogurtistanAvatar(obj.material).blendConstant = blendSlider.value;
				}
				blendLabel.text = ""+blendSlider.value;
			});
			
			blendSlider.minimum = 0;
			blendSlider.maximum = 10;
			blendSlider.value = MaterialYogurtistanAvatar((_avatar.children[0] as SceneObjectRenderable).material).blendConstant;
			blendSlider.tick = 0.1;
			
			blendLabel  = new Label(m_avatarUI, blendSlider.x+ blendSlider.width + 8,  lab.y,""+blendSlider.value);
			//			
			
			cMap = new CheckBox(m_avatarUI, 5, 55, "Color Map", function():void{
				var obj:SceneObjectRenderable;
				if(cMap.selected){
					for(var i:uint=0; i < _avatar.children.length; i++){
						obj = _avatar.children[i];
						if(i == 46)
							MaterialYogurtistanAvatar(obj.material).colorMap = m_rMan.getUsualTextures("FemaleSac");
						else if(i != 44 && i != 45)
							MaterialYogurtistanAvatar(obj.material).colorMap = m_rMan.getUsualTextures("FemaleBody");
						else
							MaterialYogurtistanAvatar(obj.material).colorMap = m_rMan.getUsualTextures("FemaleSurat");
					}
					
				}else{
					
					for(i=0; i < _avatar.children.length; i++){
						obj = _avatar.children[i];
						MaterialYogurtistanAvatar(obj.material).colorMap = null;
					}
				}
				
			});
			
			cMap.selected = !(MaterialYogurtistanAvatar((_avatar.children[0] as SceneObjectRenderable).material).colorMap == TextureMapDefaults.WHITEMIPMAP);
			
			lab  = new Label(m_avatarUI, 5,  70, "FRESNEL");
			
			lab  = new Label(m_avatarUI, 5,  85, "fSpecPow:");
			fSpecPowerSlider = new HSlider(m_avatarUI, lab.x+ lab.width + 5, lab.y, function():void{
				var obj:SceneObjectRenderable;
				for(var i:uint=0; i < _avatar.children.length; i++){
					obj = _avatar.children[i];
					MaterialYogurtistanAvatar(obj.material).fspecPower = fSpecPowerSlider.value;
				}
				freRefLabel.text = ""+(fSpecPowerSlider.value);
			});
			
			fSpecPowerSlider.minimum = 0;
			fSpecPowerSlider.maximum = 5;
			fSpecPowerSlider.value = MaterialYogurtistanAvatar((_avatar.children[0] as SceneObjectRenderable).material).fspecPower;
			fSpecPowerSlider.tick = 0.1;
			
			freRefLabel  = new Label(m_avatarUI, fSpecPowerSlider.x+ fSpecPowerSlider.width + 8,  lab.y,""+(fSpecPowerSlider.value));
			
			lab  = new Label(m_avatarUI, 5,  105, "fRimPow:");
			
			fRimPowerSlider = new HSlider(m_avatarUI, lab.x+ lab.width + 5, lab.y, function():void{
				
				var obj:SceneObjectRenderable;
				for(var i:uint=0; i < _avatar.children.length; i++){
					obj = _avatar.children[i];
					MaterialYogurtistanAvatar(obj.material).fRimPower = fRimPowerSlider.value;
				}
				freRimLabel.text = ""+(fRimPowerSlider.value);
			});
			
			fRimPowerSlider.minimum = 0;
			fRimPowerSlider.maximum = 5;
			fRimPowerSlider.value = MaterialYogurtistanAvatar((_avatar.children[0] as SceneObjectRenderable).material).fRimPower;
			fRimPowerSlider.tick = 0.1;
			var freRimLabel:Label  = new Label(m_avatarUI, fRimPowerSlider.x+ fRimPowerSlider.width + 8,  lab.y,""+(fRimPowerSlider.value));
			
			lab  = new Label(m_avatarUI, 5,  130, "SHINE");
			
			lab  = new Label(m_avatarUI, 5,  145, "shinness");
			var shineSlider:NumericStepper = new NumericStepper(m_avatarUI, lab.x+ lab.width + 5, lab.y + 4, function():void{
				
				var obj:SceneObjectRenderable;
				for(var i:uint=0; i < _avatar.children.length; i++){
					obj = _avatar.children[i];
					MaterialYogurtistanAvatar(obj.material).shineness = shineSlider.value;
				}
			});
			
			shineSlider.minimum = 0;
			shineSlider.maximum = 200;
			shineSlider.value = MaterialYogurtistanAvatar((_avatar.children[0] as SceneObjectRenderable).material).shineness;
			shineSlider.step = 0.1;
			
			var shineMap:CheckBox = new CheckBox(m_avatarUI, 5, 170, "Shine Mask", function():void{
				var obj:SceneObjectRenderable;
				if(shineMap.selected){
					for(var i:uint=0; i < _avatar.children.length; i++){
						obj = _avatar.children[i];
						
						if(i == 44)
							MaterialYogurtistanAvatar(obj.material).shinenessMask = m_rMan.getUsualTextures("SpecularFaceMap");
						else if(i == 46)
							MaterialYogurtistanAvatar(obj.material).shinenessMask = m_rMan.getUsualTextures("SpecularSac");
						else
							MaterialYogurtistanAvatar(obj.material).shinenessMask = m_rMan.getUsualTextures("SpecularMap");
					}
				}else{
					for(i=0; i < _avatar.children.length; i++){
						obj = _avatar.children[i];
						MaterialYogurtistanAvatar(obj.material).shinenessMask = null;
					}
				}
			});
			
			lab  = new Label(m_avatarUI, 5,  190, "RIM");
			lab  = new Label(m_avatarUI, 5,  205, "rim:");
			var rimSlider:NumericStepper = new NumericStepper(m_avatarUI, lab.x+ lab.width + 5, lab.y + 4, function():void{
				
				var obj:SceneObjectRenderable;
				for(var i:uint=0; i < _avatar.children.length; i++){
					obj = _avatar.children[i];
					MaterialYogurtistanAvatar(obj.material).rim = rimSlider.value;
				}
			});
			
			rimSlider.minimum = 0;
			rimSlider.maximum = 1;
			rimSlider.value = MaterialYogurtistanAvatar((_avatar.children[0] as SceneObjectRenderable).material).rim;
			rimSlider.step = 0.1;
			
			lab  = new Label(m_avatarUI, 5,  225, "rimShine:");
			var rimShineSlider:NumericStepper = new NumericStepper(m_avatarUI, lab.x+ lab.width + 5, lab.y + 4, function():void{
				
				var obj:SceneObjectRenderable;
				for(var i:uint=0; i < _avatar.children.length; i++){
					obj = _avatar.children[i];
					MaterialYogurtistanAvatar(obj.material).rimShineness = rimShineSlider.value;
				}
			});
			
			rimShineSlider.minimum = 0;
			rimShineSlider.maximum = 10;
			rimShineSlider.value = MaterialYogurtistanAvatar((_avatar.children[0] as SceneObjectRenderable).material).rimShineness;
			rimShineSlider.step = 0.1;
			
			lab  = new Label(m_avatarUI, 5,  250, "SPECULAR");
			
			// specularMap
			var specMap:CheckBox = new CheckBox(m_avatarUI, 5, 270, "Spec Map", function():void{
				var obj:SceneObjectRenderable;
				if(specMap.selected){
					for(var i:uint=0; i < _avatar.children.length; i++){
						obj = _avatar.children[i];
						
						if(i == 44)
							MaterialYogurtistanAvatar(obj.material).specularMap = m_rMan.getUsualTextures("SpecularFaceMap");
						else if(i == 46)
							MaterialYogurtistanAvatar(obj.material).specularMap = m_rMan.getUsualTextures("SpecularSac");
						else
							MaterialYogurtistanAvatar(obj.material).specularMap = m_rMan.getUsualTextures("SpecularMap");
						
					}
				}else{
					for(i=0; i < _avatar.children.length; i++){
						obj = _avatar.children[i];
						MaterialYogurtistanAvatar(obj.material).specularMap = null;
						MaterialYogurtistanAvatar(obj.material).specular = 1.0;
					}
					
					specularSlider.value = 1;
				}
			});
			
			lab  = new Label(m_avatarUI, 5,  290, "specular:");
			// specular
			var specularSlider:NumericStepper = new NumericStepper(m_avatarUI, lab.x+ lab.width + 5, lab.y + 4, function():void{
				
				var obj:SceneObjectRenderable;
				for(var i:uint=0; i < _avatar.children.length; i++){
					obj = _avatar.children[i];
					MaterialYogurtistanAvatar(obj.material).specular = specularSlider.value;
				}
			});
			
			specularSlider.minimum = 0;
			specularSlider.maximum = 1;
			specularSlider.value = MaterialYogurtistanAvatar((_avatar.children[0] as SceneObjectRenderable).material).specular;
			specularSlider.step = 0.1;
			// specularColor
			
			lab  = new Label(m_avatarUI, 80,  266, "SColor");
			var specChooserMat:ColorChooser = new ColorChooser( m_avatarUI,115, 266, 0xFFFFFF, function():void{
				
				var color:uint = specChooserMat.value;
				var m_color:Vector.<Number> = new Vector.<Number>;
				m_color[0] = (color >> 16 & 255 ) / 255;
				m_color[1] = (color >> 8 & 255) / 255;
				m_color[2] = (color & 255) / 255;
				
				var obj:SceneObjectRenderable;
				for(var i:uint=0; i < _avatar.children.length; i++){
					obj = _avatar.children[i];
					MaterialYogurtistanAvatar(obj.material).specColor = new Color(m_color[0], m_color[1], m_color[2]);;
				}
				
			});
			specChooserMat.usePopup = true;
			specChooserMat.useHandCursor = true;
				
			lab  = new Label(m_avatarUI, 5,  305, "EMMISIVE");
			
			// specularMap
			var emMap:CheckBox = new CheckBox(m_avatarUI, 5, 320, "Emmisive", function():void{
				var obj:SceneObjectRenderable;
				if(emMap.selected){
					for(var i:uint=0; i < _avatar.children.length; i++){
						obj = _avatar.children[i];
						MaterialYogurtistanAvatar(obj.material).emmisiveMask = m_rMan.getUsualTextures("SpecularMap");
					}
				}else{
					for(i=0; i < _avatar.children.length; i++){
						obj = _avatar.children[i];
						MaterialYogurtistanAvatar(obj.material).emmisiveMask = null;
					}
					
				}
			});
			
			animations = new ComboBox(m_avatarUI, 5 , 340);
			animations.addItem("IDLE");
			animations.addItem("WALK");
			animations.addItem("RUN");
			animations.selectedItem = "IDLE";
			
			animations.addEventListener(Event.SELECT, function():void{
				var obj:SceneObjectRenderable;
				for(var i:uint=0; i < _avatar.children.length; i++){
					obj = _avatar.children[i] as SceneObjectRenderable;
					SkinController(SkeletalAnimatedMesh(obj.geometry).controller).playAnimation(animations.selectedItem as String);
				}
			});
			
		}
		
		/*******************************************************************************************************
		 * 
		 *  LIGHT UI
		 * 
		 * *****************************************************************************************************/

		public function createLightUI(_light:Light, _posX:Number=0, _posY:Number=0):void{
			
			m_IdName = new Dictionary;
			
			Style.setStyle( Style.DARK);
			var mainWindow:Window = new Window(m_parent, _posX, _posY, "Parameters");
			mainWindow.width = 200;
			mainWindow.height = 220;
			
			objects = new ComboBox(mainWindow, 5, 10);
			var obj:SceneObjectRenderable;
			
			for (var key:Object in m_rMan.models) {
				objects.addItem(key);
				obj = (m_rMan.sceneObjs[key] as SceneObjectRenderable);
				obj.onMouseDoubleClick.add(onObjSelected);
				m_IdName[obj.systemID] = key;
	
			}
			
			var len:uint = m_rMan.avatar.children.length;
			for(var i:uint = 0; i < len; i++){
				m_rMan.avatar.children[i].interactive = true;
				m_rMan.avatar.children[i].pickEnabled = true;
				m_rMan.avatar.children[i].onMouseDoubleClick.add(onAvatarSelected);
			}
			
			objects.addItem("AVATAR");
			
			objects.addEventListener(Event.SELECT, function():void{
				m_selectedObj = m_rMan.sceneObjs[objects.selectedItem];
				
				if(m_selectedObj && m_selectedObj.material is MaterialYogurtistanLocationV2){
					allMAterial.enabled = true;
					allMAterial.visible = true;
					avatarGradient.visible = false;
					m_avatarUI.visible = false;
					opacitySlider.value = MaterialYogurtistanLocationV2(m_selectedObj.material).opacity;
					opLabel.text = ""+opacitySlider.value;
						
						if(MaterialYogurtistanLocationV2(m_selectedObj.material).reflectionMap == vasa.texture){
							refMapsC.selectedItem = "Vasa";
						}else if(MaterialYogurtistanLocationV2(m_selectedObj.material).reflectionMap == outside.texture){
							refMapsC.selectedItem = "Outside";
						}else if(MaterialYogurtistanLocationV2(m_selectedObj.material).reflectionMap == night.texture){
							refMapsC.selectedItem = "Night";
						}else{
							refMapsC.selectedItem = "None";
						}
						refAlphaSlider.value = MaterialYogurtistanLocationV2(m_selectedObj.material).reflectionAlpha;
						refLabel.text = ""+refAlphaSlider.value;
						fresnelPower.value = MaterialYogurtistanLocationV2(m_selectedObj.material).fresnelPower;
						powLabel.text = ""+fresnelPower.value;
						reflectance.value = MaterialYogurtistanLocationV2(m_selectedObj.material).fresnelReflectance*100;
						freRefLabel.text = "" + reflectance.value/100;
					
						cMap.selected = !(MaterialYogurtistanLocationV2(m_selectedObj.material).colorMap == TextureMapDefaults.WHITEMIPMAP);
						
						kSpecSlider.value = MaterialYogurtistanLocationV2(m_selectedObj.material).shineness;
						ksSlider.value = MaterialYogurtistanLocationV2(m_selectedObj.material).specular;
						ksColorLabel.text = ""+ksSlider.value;
						sMask.selected = !(MaterialYogurtistanLocationV2(m_selectedObj.material).specularMap == TextureMapDefaults.BLACKMIPMAP);
						specChooserMat.value = MaterialYogurtistanLocationV2(m_selectedObj.material).specColor.toUintRGB();
						// TODOspecChooserMat
						
//						eMap.selected = !(MaterialYogurtistanLocationNight(m_selectedObj.material).emmisiveMask == TextureMapDefaults.BLACK);
						emmisiveAlpha.value = MaterialYogurtistanLocationV2(m_selectedObj.material).emmisiveAlpha;
						emmLabel.text = ""+emmisiveAlpha.value;
						blendSlider.value = MaterialYogurtistanLocationV2(m_selectedObj.material).blendConstant;
						blendLabel.text = ""+blendSlider.value;					
						lMap.selected = !(MaterialYogurtistanLocationV2(m_selectedObj.material).lightMap == TextureMapDefaults.WHITE);		
				}else{
					allMAterial.visible = false;
					locGradient.visible = false;
					avatarGradient.visible = true;
					m_avatarUI.visible = true;
				}
				
			});
			
			if(_light){
				var lab:Label = new Label(mainWindow, 5,  35, "Directional Color:");
				var colorChooser1:ColorChooser = new ColorChooser( mainWindow, lab.width + 20, lab.y, _light.color.toUint(), function():void{
					
					var color:uint = colorChooser1.value;
					var m_color:Vector.<Number> = new Vector.<Number>;
					m_color[0] = (color >> 16 & 255 ) / 255;
					m_color[1] = (color >> 8 & 255) / 255;
					m_color[2] = (color & 255) / 255;
					
					_light.color = new Color(m_color[0], m_color[1], m_color[2]);
					
				});	
				colorChooser1.usePopup = true;
				colorChooser1.useHandCursor = true;
			}
			
			lab = new Label(mainWindow, 5,  50, "Rotation:");
			
			var dirX:HSlider = new HSlider(mainWindow,5, lab.y + 15, function():void{
				
				_light.transformation.rotationX = dirX.value;
				//	m_selectedLight.
				rotX.text = "" + dirX.value;
			});
			
			dirX.minimum = -360;
			dirX.maximum = 360;
			dirX.value = _light.transformation.rotationX;
			var rotX:Label = new Label(mainWindow, dirX.width + 5, dirX.y - 3, ""+dirX.value);
			
			var dirY:HSlider = new HSlider(mainWindow,5, lab.y + 35, function():void{
				
				_light.transformation.rotationY = dirY.value;
				rotY.text = "" + dirY.value;
				//	m_selectedLight.
			});
			
			dirY.minimum = -360;
			dirY.maximum = 360;
			dirY.value = _light.transformation.rotationY;
			var rotY:Label = new Label(mainWindow, dirY.width+5, dirY.y  - 3, ""+dirY.value);
			
			var dirZ:HSlider = new HSlider(mainWindow,5, lab.y + 55, function():void{
				
				_light.transformation.rotationZ = dirZ.value;
				rotZ.text = "" + dirZ.value;
				//	m_selectedLight.
			});
			
			dirZ.minimum = -360;
			dirZ.maximum = 360;
			dirZ.value = _light.transformation.rotationZ;
			var rotZ:Label = new Label(mainWindow, dirZ.width+5, dirZ.y - 3, ""+dirZ.value);
			
			lab = new Label(mainWindow, 5,  120, "Position:");
			
			var posX:HSlider = new HSlider(mainWindow,5, lab.y + 15, function():void{
				
				_light.transformation.x = posX.value;
				//	m_selectedLight.
			});
			
			posX.minimum = -360;
			posX.maximum = 360;
			posX.value = _light.transformation.x;
			posX.tick = 0.1;
			
			var posY:HSlider = new HSlider(mainWindow,5, lab.y + 35, function():void{
				
				_light.transformation.y = posY.value;
				
			});
			
			posY.minimum = -360;
			posY.maximum = 360;
			posY.value = _light.transformation.y;
			posY.tick = 0.1;
			
			var posZ:HSlider = new HSlider(mainWindow,5, lab.y + 55, function():void{
				
				_light.transformation.z = posZ.value;
				//	m_selectedLight.
			});
			
			posZ.minimum = -360;
			posZ.maximum = 360;
			posZ.value = _light.transformation.z;
			posZ.tick = 0.1;
			
		}
		
		/*******************************************************************************************************
		 * 
		 * GRADIENT LOCATION
		 * 
		 * *****************************************************************************************************/
		
		public static const AMB_UP:Color = Color.WHITE;
		public static const AMB_DOWN:Color = Color.BLACK;
		
		private var m_difLoccolors:Array;
		private var diffuseLocation:Component;
		
		public static const DIFFUSE_GRADIENT:TextureMap = new TextureMap(createDiffuseGradient([0x3E3D3F, 0x3F3F3F, 0x747E8B]));
		
		private static function createDiffuseGradient(m_colors:Array, _height:int=1):BitmapData{
				var slider:Array = [0,128,256];
				var gradient:Sprite = new Sprite();
						
				gradient.graphics.clear();
				var mat:Matrix = new Matrix();
				mat.createGradientBox( slider[1]-slider[0], _height, 0, slider[0],0);
				gradient.graphics.beginGradientFill(GradientType.LINEAR, m_colors.slice(0,2) , [1,1], [0,255], mat, SpreadMethod.PAD );
				gradient.graphics.drawRect(slider[0],0,slider[1]-slider[0],_height);
				gradient.graphics.endFill();
						
				mat = new Matrix();
				mat.createGradientBox( slider[2]-slider[1], _height, 0, slider[1],0);
				gradient.graphics.beginGradientFill(GradientType.LINEAR, m_colors.slice(1,3), [1,1], [0,255], mat, SpreadMethod.PAD );
				gradient.graphics.drawRect(slider[1],0,slider[2]-slider[1],_height);
				gradient.graphics.endFill();
			
				var bitmapData:BitmapData = new BitmapData(256,_height);
				bitmapData.draw( gradient );
						
				return bitmapData;
		}
		
		private var locGradient:Window ;
		public function createLocGradientUI(_posX:Number=0, _posY:Number=0):void{
			locGradient = new Window(m_parent, _posX, _posY, "LOCATION Gradient");
			locGradient.width = 270;
			locGradient.height = 200;
			
			var lab:Label = new Label(locGradient, 5, 5, "AMBIENT Up/Down");
					
			var c1:ColorChooser = new ColorChooser( locGradient, 5, 25, 0xFFFFFF, function():void{
				
				var color:uint = c1.value;
				var m_color:Vector.<Number> = new Vector.<Number>;
				m_color[0] = (color >> 16 & 255 ) / 255;
				m_color[1] = (color >> 8 & 255) / 255;
				m_color[2] = (color & 255) / 255;
				
				var obj:SceneObjectRenderable;
				
				for (var key:Object in m_rMan.models) {
					obj = (m_rMan.sceneObjs[key] as SceneObjectRenderable);
					
					MaterialYogurtistanLocationV2(obj.material).ambientUpColor = new Color(m_color[0], m_color[1],m_color[2]);
				}
				
			});
			c1.usePopup = true;
			c1.useHandCursor = true;
			
			var c2:ColorChooser = new ColorChooser( locGradient, 100, 25, 0x000000, function():void{
				var color:uint = c2.value;
				var m_color:Vector.<Number> = new Vector.<Number>;
				m_color[0] = (color >> 16 & 255 ) / 255;
				m_color[1] = (color >> 8 & 255) / 255;
				m_color[2] = (color & 255) / 255;
				
				var obj:SceneObjectRenderable;
				
				for (var key:Object in m_rMan.models) {
					obj = (m_rMan.sceneObjs[key] as SceneObjectRenderable);
					
					MaterialYogurtistanLocationV2(obj.material).ambientDownColor = new Color(m_color[0], m_color[1],m_color[2]);
				}
				
			});
			c2.usePopup = true;
			c2.useHandCursor = true;
			lab  = new Label(locGradient, 5,  45, "DIFFUSE");
					
			m_difLoccolors = new Array;
			m_difLoccolors[0] = 0x3E3D3F;
			m_difLoccolors[1] = 0x3F3F3F;
			m_difLoccolors[2] = 0x747E8B;
		
			diffuseLocation = new Component(locGradient, 0, 100);
			diffuseLocation.width = 200;
			diffuseLocation.height = 30;
			drawDiffuseLocGradient();
					
				var d1:ColorChooser = new ColorChooser( locGradient, 150, 75, m_difLoccolors[0], function():void{
					m_difLoccolors[0] = d1.value;
					drawDiffuseLocGradient();
				});
				d1.usePopup = true;
				d1.useHandCursor = true;
					
				var d2:ColorChooser = new ColorChooser( locGradient, 75, 75, m_difLoccolors[1], function():void{
					m_difLoccolors[1] = d2.value;	
					drawDiffuseLocGradient();
				});
				d2.usePopup = true;
				d2.useHandCursor = true;
					
				var d3:ColorChooser = new ColorChooser( locGradient, 0, 75, m_difLoccolors[2], function():void{
					m_difLoccolors[2] = d3.value;	
					drawDiffuseLocGradient();
				});
				d3.usePopup = true;
				d3.useHandCursor = true;
					
				
				lab  = new Label(locGradient, 5,  140, "Scene Color:");
					
				var sceneColor:ColorChooser = new ColorChooser( locGradient, 80, 140, 0x000000, function():void{
						
					var color:uint = sceneColor.value;
					var m_color:Vector.<Number> = new Vector.<Number>;
					m_color[0] = (color >> 16 & 255 ) / 255;
					m_color[1] = (color >> 8 & 255) / 255;
					m_color[2] = (color & 255) / 255;
						
					m_setup.scene.sceneColor.r = m_color[0]
					m_setup.scene.sceneColor.g = m_color[1]
					m_setup.scene.sceneColor.b = m_color[2]
				});
				sceneColor.usePopup = true;
				sceneColor.useHandCursor = true;

					
		}

		private function getDifLocGrad(_height:Number, _posY:Number=0):Sprite{
			var slider:Array = [0,128, 256];
			var gradient:Sprite = new Sprite();
			
			gradient.graphics.clear();
			var mat:Matrix = new Matrix();
			mat.createGradientBox( slider[1]-slider[0], _height, 0, slider[0],_posY);
			gradient.graphics.beginGradientFill(GradientType.LINEAR, m_difLoccolors.slice(0,2) , [1,1], [0,255], mat, SpreadMethod.PAD );
			gradient.graphics.drawRect(slider[0],_posY,slider[1]-slider[0],_height);
			gradient.graphics.endFill();
			
			mat = new Matrix();
			mat.createGradientBox( slider[2]-slider[1], _height, 0, slider[1],_posY);
			gradient.graphics.beginGradientFill(GradientType.LINEAR, m_difLoccolors.slice(1,3), [1,1], [0,255], mat, SpreadMethod.PAD );
			gradient.graphics.drawRect(slider[1],_posY,slider[2]-slider[1],_height);
			gradient.graphics.endFill();
				
			return gradient;
		}
	
		private function drawDiffuseLocGradient():void{
			
			var bitmapData:BitmapData = new BitmapData(256,1);
			bitmapData.draw( getDifLocGrad(1) );
			DIFFUSE_GRADIENT.bitmapData = bitmapData;	
			diffuseLocation.addChild(getDifLocGrad(20));
		}
		
		/*******************************************************************************************************
		 * 
		 * GRADIENT AVATAR
		 * 
		 * *****************************************************************************************************/
		public static const GRADIENT_AVATAR:TextureMap = new TextureMap(setAvatarGradient([0x3E3D3F, 0x3F3F3F, 0x48464C], [0x808080, 0]));
		private static function setAvatarGradient(_difColors:Array, _ambColors:Array):BitmapData{
			
			var slider:Array = [0, 128, 256];
			var gradient:Sprite = new Sprite();
			
			var _height:Number = 2;
			var _posY:Number = 0;
			
			gradient.graphics.clear();
			var mat:Matrix = new Matrix();
			mat.createGradientBox( slider[1]-slider[0], _height, 0, slider[0],_posY);
			gradient.graphics.beginGradientFill(GradientType.LINEAR, _difColors.slice(0,2) , [1,1], [0,255], mat, SpreadMethod.PAD );
			gradient.graphics.drawRect(slider[0],_posY,slider[1]-slider[0],_height);
			gradient.graphics.endFill();
			
			mat = new Matrix();
			mat.createGradientBox( slider[2]-slider[1], _height, 0, slider[1],_posY);
			gradient.graphics.beginGradientFill(GradientType.LINEAR, _difColors.slice(1,3), [1,1], [0,255], mat, SpreadMethod.PAD );
			gradient.graphics.drawRect(slider[1],_posY,slider[2]-slider[1],_height);
			gradient.graphics.endFill();
			
//			mat = new Matrix();
//			mat.createGradientBox( slider[3]-slider[2], _height, 0, slider[2],_posY);
//			gradient.graphics.beginGradientFill(GradientType.LINEAR, _difColors.slice(2,4), [1,1], [0,255], mat, SpreadMethod.PAD );
//			gradient.graphics.drawRect(slider[2],_posY,slider[3]-slider[2],_height);
//			gradient.graphics.endFill();
//			
//			mat = new Matrix();
//			mat.createGradientBox( slider[4]-slider[3], _height, 0, slider[3],_posY);
//			gradient.graphics.beginGradientFill(GradientType.LINEAR, _difColors.slice(3,5), [1,1], [0,255], mat, SpreadMethod.PAD );
//			gradient.graphics.drawRect(slider[3],_posY,slider[4]-slider[3],_height);
//			gradient.graphics.endFill();
			
			slider = [0,256];
			_posY = 2;
			
			mat = new Matrix();
			mat.createGradientBox( slider[1]-slider[0], _height, 0, slider[0],_posY);
			gradient.graphics.beginGradientFill(GradientType.LINEAR, _ambColors.slice(0,2) , [1,1], [0,255], mat, SpreadMethod.PAD );
			gradient.graphics.drawRect(slider[0],_posY,slider[1]-slider[0],_height);
			gradient.graphics.endFill();
			
			var bitmapData:BitmapData = new BitmapData(256,4);
			bitmapData.draw( gradient);
			
			return bitmapData;
		}
	
		private var avatarGradient:Window;
		private var ambient:Component;
		private var diffuse:Component;
		private var combined:Component;
		private var c1:ColorChooser;
		private var c2:ColorChooser; 
		
		private var d1:ColorChooser;
		private var d2:ColorChooser;
		private var d3:ColorChooser;
		private var d4:ColorChooser;
		private var d5:ColorChooser;
		private var m_colors:Array;
		private var m_difcolors:Array;
		public function createGradientAvatar(_posX:Number=0, _posY:Number=0):void{
			avatarGradient = new Window(m_parent, _posX, _posY, "AVATAR Gradient");
			avatarGradient.width = 260;
			avatarGradient.height = 200;
			avatarGradient.visible = false;
			
			var lab:Label  = new Label(avatarGradient, 5,  5, "Ambient:");
			
			ambient = new Component(avatarGradient, 0, 40);
			ambient.width = 200;
			ambient.height = 20;
			
			combined = new Component(avatarGradient, 0, 130);
			combined.width = 200;
			combined.height = 4;
			
			m_colors = new Array;
			
			m_colors[0] = 0x808080;
			m_colors[1] = 0x000000;
			drawGradient();
			c1 = new ColorChooser( avatarGradient, 0, 20, 0x808080, function():void{
				
				m_colors[0] = c1.value;
				drawGradient();
				drawCombinedGradient();
				
			});
			c1.usePopup = true;
			c1.useHandCursor = true;
			
			c2 = new ColorChooser( avatarGradient, 100, 20, 0x000000, function():void{
				m_colors[1] = c2.value;
				drawGradient();
				drawCombinedGradient();
			});
			c2.usePopup = true;
			c2.useHandCursor = true;
			
			m_difcolors = new Array;
			m_difcolors[0] = 0x3E3D3F;
			m_difcolors[1] = 0x3F3F3F;
			m_difcolors[2] = 0x48464C;
	
			
			diffuse = new Component(avatarGradient, 0, 105);
			diffuse.width = 200;
			diffuse.height = 30;
			drawDiffuseGradient();
			drawCombinedGradient();
			
			lab  = new Label(avatarGradient, 5,  60, "Diffuse:");
			d1 = new ColorChooser( avatarGradient, 150, 75, 0x3E3D3F, function():void{
				m_difcolors[0] = d1.value;
				drawDiffuseGradient();
				drawCombinedGradient();
			});
			d1.usePopup = true;
			d1.useHandCursor = true;
			
			
			d2 = new ColorChooser( avatarGradient, 75, 75, 0x3F3F3F, function():void{
				m_difcolors[1] = d2.value;	
				drawDiffuseGradient();
				drawCombinedGradient();
			});
			d2.usePopup = true;
			d2.useHandCursor = true;
			
			d3 = new ColorChooser( avatarGradient, 0, 75, 0x48464C, function():void{
				m_difcolors[2] = d3.value;		
				drawDiffuseGradient();
				drawCombinedGradient();
			});
			d3.usePopup = true;
			d3.useHandCursor = true;
			
		}
		private function drawCombinedGradient():void{
			
			var slider:Array = [0,128,256];
			var gradient:Sprite = new Sprite();
			
			var _height:Number = 1;
			var _posY:Number = 0;
			
			gradient.graphics.clear();
			var mat:Matrix = new Matrix();
			mat.createGradientBox( slider[1]-slider[0], _height, 0, slider[0],_posY);
			gradient.graphics.beginGradientFill(GradientType.LINEAR, m_difcolors.slice(0,2) , [1,1], [0,255], mat, SpreadMethod.PAD );
			gradient.graphics.drawRect(slider[0],_posY,slider[1]-slider[0],_height);
			gradient.graphics.endFill();
			
			mat = new Matrix();
			mat.createGradientBox( slider[2]-slider[1], _height, 0, slider[1],_posY);
			gradient.graphics.beginGradientFill(GradientType.LINEAR, m_difcolors.slice(1,3), [1,1], [0,255], mat, SpreadMethod.PAD );
			gradient.graphics.drawRect(slider[1],_posY,slider[2]-slider[1],_height);
			gradient.graphics.endFill();
	
			
			slider = [0,256];
			_posY = 1;
			
			mat = new Matrix();
			mat.createGradientBox( slider[1]-slider[0], _height, 0, slider[0],_posY);
			gradient.graphics.beginGradientFill(GradientType.LINEAR, m_colors.slice(0,2) , [1,1], [0,255], mat, SpreadMethod.PAD );
			gradient.graphics.drawRect(slider[0],_posY,slider[1]-slider[0],_height);
			gradient.graphics.endFill();
			
			combined.addChild(gradient);
			
			var bitmapData:BitmapData = new BitmapData(256,2);
			bitmapData.draw( gradient );
			
			GRADIENT_AVATAR.bitmapData = bitmapData;
			
		}
		
		private function drawGradient():void{
			var bitmapData:BitmapData = new BitmapData(256,2);
			bitmapData.draw( getAmbGrad(2) );
			ambient.addChild(getAmbGrad(20));
		}
		
		private function drawDiffuseGradient():void{		
			var bitmapData:BitmapData = new BitmapData(256,2);
			bitmapData.draw( getDifGrad(2) );			
			diffuse.addChild(getDifGrad(20));	
		}
		private function getDifGrad(_height:Number, _posY:Number=0):Sprite{
			var slider:Array = [0,128,256];
			var gradient:Sprite = new Sprite();
			
			gradient.graphics.clear();
			var mat:Matrix = new Matrix();
			mat.createGradientBox( slider[1]-slider[0], _height, 0, slider[0],_posY);
			gradient.graphics.beginGradientFill(GradientType.LINEAR, m_difcolors.slice(0,2) , [1,1], [0,255], mat, SpreadMethod.PAD );
			gradient.graphics.drawRect(slider[0],_posY,slider[1]-slider[0],_height);
			gradient.graphics.endFill();
			
			mat = new Matrix();
			mat.createGradientBox( slider[2]-slider[1], _height, 0, slider[1],_posY);
			gradient.graphics.beginGradientFill(GradientType.LINEAR, m_difcolors.slice(1,3), [1,1], [0,255], mat, SpreadMethod.PAD );
			gradient.graphics.drawRect(slider[1],_posY,slider[2]-slider[1],_height);
			gradient.graphics.endFill();
		
			return gradient;
		}
		
		private function getAmbGrad(_height:Number, _posY:Number=0):Sprite{
			var slider:Array = [0,256];
			var gradient:Sprite = new Sprite();
			
			gradient.graphics.clear();
			var mat:Matrix = new Matrix();
			mat.createGradientBox( slider[1]-slider[0], _height, 0, slider[0],_posY);
			gradient.graphics.beginGradientFill(GradientType.LINEAR, m_colors.slice(0,2) , [1,1], [0,255], mat, SpreadMethod.PAD );
			gradient.graphics.drawRect(slider[0],_posY,slider[1]-slider[0],_height);
			gradient.graphics.endFill();
			
			return gradient;
		}
		
		
		/*******************************************************************************************************
		 * 
		 * POST EFFECTS
		 * 
		 * *****************************************************************************************************/
		private var DREAM:uint = 0;
		private var GREYSCALE:uint = 1;
		private var HUE_SATURATION:uint = 2;
		private var NEGATIVE:uint = 3;
		private var POSTERIZATION:uint = 4;
		private var BRIGHT_CONTRAST:uint = 5;
		private var GAMMA_CHANNEL:uint = 6;
		private var GAMMA_CORRECTION:uint = 7;
		private var SEPHIA:uint = 8;
		private var EMBOSS:uint = 9;
		private var LAPLACIAN:uint = 10;
		private var SHARPEN:uint = 11;
		private var PIXELATION:uint = 12;
		private var NOISE:uint = 13;
		private var SWIRL:uint = 14;
		private var THERMAL_VISION:uint = 15;
		private var VIBRANCE:uint = 16;
		private var DOTSCREEN:uint = 17;
		private var LENS_CIRCLE:uint = 18;
		private var RADIAL_BLUR:uint = 19;
		private var COLOR_GRADING:uint = 20;
		private var NIGHT_VISION:uint = 21;
		private var SCRATCHED_FILM:uint = 22;
		
		private var postEffects:Vector.<PostProcessingEffectBase>;
		private var postCombo:ComboBox;
		private var currentEffect:PostProcessingEffectBase= null;
		private var _window:Vector.<Window>;
		public function createPostEffectUI( _posX:Number=0, _posY:Number=0,
											_posX2:Number=0, _posY2:Number=0):void{
			
			postEffects = new Vector.<PostProcessingEffectBase>;
			postEffects.push(new EffectDream());//0
			postEffects.push(new EffectGreyScale());//0
			postEffects.push(new EffectHueSaturation());
			postEffects.push(new EffectNegative());
			postEffects.push(new EffectPosterization());
			postEffects.push(new EffectBrightnessContrast());
			postEffects.push(new EffectGammaCorChannel(1.2, 2.1, 2.0));
			postEffects.push(new EffectGammaCorrection(1.2));//1
			postEffects.push(new EffectSephia());//1
			postEffects.push(new EffectEmboss());
			postEffects.push(new EffectLaplacian());
			postEffects.push(new EffectSharpen());
			postEffects.push(new EffectPixelation());
			postEffects.push(new EffectNoise());
			postEffects.push(new EffectSwirl());
			postEffects.push(new EffectThermalVision(//8
				new Color(0,0,1),
				new Color(1,1,0),
				new Color(1,0,0)));
			postEffects.push(new EffectVibrance());
			postEffects.push(new EffectDotScreen());
			postEffects.push(new EffectLensCircle());
			postEffects.push(new EffectRadialBlur());
			
			postEffects.push(new EffectColorGrading(m_rMan.getUsualTextures("colorGradient")));
			postEffects.push(new EffectNightVision(m_rMan.getUsualTextures("noise"), 
				m_rMan.getUsualTextures("mask"), 150
			));
			
			postEffects.push(new EffectScrathedFilm(m_rMan.getUsualTextures("noise2")));
			
			Style.setStyle( Style.DARK);
			postCombo = new ComboBox(m_parent, _posX, _posY, "None");
			postCombo.width = 200;
			postCombo.selectedIndex = 0;		
			postCombo.addItem("None");
			postCombo.addItem("Dream");
			postCombo.addItem("Greyscale");
			postCombo.addItem("Hue/Saturation");
			postCombo.addItem("Negative");
			postCombo.addItem("Posterization");	
			postCombo.addItem("Brightness/Cont");
			postCombo.addItem("GammaCorChannel");
			postCombo.addItem("GammaCorrection");
			postCombo.addItem("Sephia");
			postCombo.addItem("Emboss");
			postCombo.addItem("Laplacian");
			postCombo.addItem("Sharpen");
			postCombo.addItem("Pixelation");
			postCombo.addItem("Noise");
			postCombo.addItem("Swirl");
			postCombo.addItem("Thermal Vision");
			postCombo.addItem("Vibrance");
			postCombo.addItem("Dot Screen");
			postCombo.addItem("Lens Circle");
			postCombo.addItem("Radial Blur");
			postCombo.addItem("Color Grading");
			postCombo.addItem("Night Vision");
			postCombo.addItem("Strached Film");
			
			_window = new Vector.<Window>(postCombo.items.length - 1);
			for(var i:uint = 0; i < _window.length; i++){
				_window[i] = null;
			}
			
			postCombo.addEventListener(Event.SELECT, function():void{
				m_setup.scene.removeAllPostEffects();
				
				if(postCombo.selectedIndex == 0)
					currentEffect = null;
				
				if(postCombo.selectedIndex > 0){
					var curIndex:uint = postCombo.selectedIndex - 1;
					var prevIndex:uint = postEffects.indexOf(currentEffect);
					m_setup.scene.postProcesses.add(postEffects[curIndex]);
					
					if(_window[curIndex] != null)
						_window[curIndex].visible = true;
					if(currentEffect != null &&
						prevIndex != -1 &&
						_window[prevIndex] != null
					){
						_window[prevIndex].visible = false;
					}
					
					currentEffect = postEffects[postCombo.selectedIndex - 1];
				}
			});
			
			// HUE_SATURATION
			
			_window[HUE_SATURATION] = new Window(m_parent, _posX2, _posY2, "Hue/Saturation");
			_window[HUE_SATURATION].hasMinimizeButton = true;
			_window[HUE_SATURATION].height = 180;
			_window[HUE_SATURATION].width = 200;
			_window[HUE_SATURATION].visible = false;
			
			var hueL:Label = new Label(_window[HUE_SATURATION],5,5,"Hue: ");
			var hueSlider:HSlider = new HSlider(_window[HUE_SATURATION],5, 20, function():void{
				EffectHueSaturation(postEffects[HUE_SATURATION]).hue = hueSlider.value;
				hueL.text = "Hue: "+ EffectHueSaturation(postEffects[HUE_SATURATION]).hue;
				
			});
			hueL.text = "Hue: "+ EffectHueSaturation(postEffects[HUE_SATURATION]).hue;
			hueSlider.minimum = -1;
			hueSlider.maximum = 1;
			hueSlider.value = EffectHueSaturation(postEffects[HUE_SATURATION]).hue;
			
			var satL:Label = new Label(_window[HUE_SATURATION],5, 45,"Saturation: ");
			var satSlider:HSlider = new HSlider(_window[HUE_SATURATION],5, 60, function():void{
				EffectHueSaturation(postEffects[HUE_SATURATION]).saturation = satSlider.value;
				satL.text = "Saturation: "+ EffectHueSaturation(postEffects[HUE_SATURATION]).saturation;
				
			});
			satL.text = "Saturation: "+ EffectHueSaturation(postEffects[HUE_SATURATION]).saturation;
			satSlider.minimum = -1;
			satSlider.maximum = 1;
			satSlider.value = EffectHueSaturation(postEffects[HUE_SATURATION]).saturation;
			
			
			// POSTERIZATION
			_window[POSTERIZATION] = new Window(m_parent, _posX2, _posY2, "Posterization");
			_window[POSTERIZATION].hasMinimizeButton = true;
			_window[POSTERIZATION].height = 180;
			_window[POSTERIZATION].width = 200;
			_window[POSTERIZATION].visible = false;
			
			var gammaPost:Label = new Label(_window[POSTERIZATION],5,5,"Gamma: ");
			var gammaPostSlider:HSlider = new HSlider(_window[POSTERIZATION],5, 20, function():void{
				EffectPosterization(postEffects[POSTERIZATION]).gamma = gammaPostSlider.value;
				gammaPost.text = "Gamma: "+ EffectPosterization(postEffects[POSTERIZATION]).gamma;
				
			});
			gammaPost.text = "Gamma: "+ EffectPosterization(postEffects[POSTERIZATION]).gamma;
			gammaPostSlider.minimum = 0;
			gammaPostSlider.maximum = 5;
			gammaPostSlider.value = EffectPosterization(postEffects[POSTERIZATION]).gamma;
			
			var numcolorL:Label = new Label(_window[POSTERIZATION],5,35,"Num of Colors: ");
			var numcolorSlider:HSlider = new HSlider(_window[POSTERIZATION],5, 50, function():void{
				EffectPosterization(postEffects[POSTERIZATION]).numColors = numcolorSlider.value;
				numcolorL.text = "Num of Colors: "+ EffectPosterization(postEffects[POSTERIZATION]).numColors;
				
			});
			numcolorL.text = "Num of Colors: "+ EffectPosterization(postEffects[POSTERIZATION]).numColors;
			numcolorSlider.minimum = 0;
			numcolorSlider.maximum = 20;
			numcolorSlider.tick = 1;
			numcolorSlider.value = EffectPosterization(postEffects[POSTERIZATION]).numColors;
			
			// BRIGHTNESS/CONTRAST
			_window[BRIGHT_CONTRAST] = new Window(m_parent, _posX2, _posY2,  "Brightness/Contrast");
			_window[BRIGHT_CONTRAST].hasMinimizeButton = true;
			_window[BRIGHT_CONTRAST].height = 180;
			_window[BRIGHT_CONTRAST].width = 200;
			_window[BRIGHT_CONTRAST].visible = false;
			
			var brightL:Label = new Label(_window[BRIGHT_CONTRAST],5,5,"Brightness: ");
			var brightSlider:HSlider = new HSlider(_window[BRIGHT_CONTRAST],5, 20, function():void{
				EffectBrightnessContrast(postEffects[BRIGHT_CONTRAST]).brightness = brightSlider.value;
				brightL.text = "Brightness: "+ EffectBrightnessContrast(postEffects[BRIGHT_CONTRAST]).brightness;
				
			});
			brightL.text = "Brightness: "+ EffectBrightnessContrast(postEffects[BRIGHT_CONTRAST]).brightness;
			brightSlider.minimum = -1;
			brightSlider.maximum = 1;
			brightSlider.value = EffectBrightnessContrast(postEffects[BRIGHT_CONTRAST]).brightness;
			
			var contrastL:Label = new Label(_window[BRIGHT_CONTRAST],5,35,"Contrast: ");
			var contrastSlider:HSlider = new HSlider(_window[BRIGHT_CONTRAST],5, 50, function():void{
				EffectBrightnessContrast(postEffects[BRIGHT_CONTRAST]).contrast = contrastSlider.value;
				contrastL.text = "Contrast: "+ EffectBrightnessContrast(postEffects[BRIGHT_CONTRAST]).contrast;
				
			});
			contrastL.text = "Contrast: "+ EffectBrightnessContrast(postEffects[BRIGHT_CONTRAST]).contrast;
			contrastSlider.minimum = -1;
			contrastSlider.maximum = 1;
			contrastSlider.value = EffectBrightnessContrast(postEffects[BRIGHT_CONTRAST]).contrast;
			
			// GAMMA CHANNEL
			_window[GAMMA_CHANNEL] = new Window(m_parent, _posX2, _posY2, "Gamma Channel");
			_window[GAMMA_CHANNEL].hasMinimizeButton = true;
			_window[GAMMA_CHANNEL].height = 180;
			_window[GAMMA_CHANNEL].width = 200;
			_window[GAMMA_CHANNEL].visible = false;
			
			var gammaLabelR:Label = new Label(_window[GAMMA_CHANNEL],5,5,"Gamma R: ");
			var gammaSliderR:HSlider = new HSlider(_window[GAMMA_CHANNEL],5, 20, function():void{
				EffectGammaCorChannel(postEffects[GAMMA_CHANNEL]).gammaR = gammaSliderR.value;
				gammaLabelR.text = "Gamma R: "+ EffectGammaCorChannel(postEffects[GAMMA_CHANNEL]).gammaR;
				
			});
			gammaLabelR.text = "Gamma R: "+ EffectGammaCorChannel(postEffects[GAMMA_CHANNEL]).gammaR;
			gammaSliderR.minimum = 0;
			gammaSliderR.maximum = 5;
			gammaSliderR.value = EffectGammaCorChannel(postEffects[GAMMA_CHANNEL]).gammaR;
			
			var gammaLabelG:Label = new Label(_window[GAMMA_CHANNEL],5,35,"Gamma G: ");
			var gammaSliderG:HSlider = new HSlider(_window[GAMMA_CHANNEL],5, 50, function():void{
				EffectGammaCorChannel(postEffects[GAMMA_CHANNEL]).gammaG = gammaSliderG.value;
				gammaLabelG.text = "Gamma G: "+ EffectGammaCorChannel(postEffects[GAMMA_CHANNEL]).gammaG;
				
			});
			gammaLabelG.text = "Gamma G: "+ EffectGammaCorChannel(postEffects[GAMMA_CHANNEL]).gammaG;
			gammaSliderG.minimum = 0;
			gammaSliderG.maximum = 5;
			gammaSliderG.value = EffectGammaCorChannel(postEffects[GAMMA_CHANNEL]).gammaG;
			
			var gammaLabelB:Label = new Label(_window[GAMMA_CHANNEL],5,65,"Gamma B: ");
			var gammaSliderB:HSlider = new HSlider(_window[GAMMA_CHANNEL],5, 80, function():void{
				EffectGammaCorChannel(postEffects[GAMMA_CHANNEL]).gammaB = gammaSliderB.value;
				gammaLabelB.text = "Gamma B: "+ EffectGammaCorChannel(postEffects[GAMMA_CHANNEL]).gammaB;
				
			});
			gammaLabelB.text = "Gamma B: "+ EffectGammaCorChannel(postEffects[GAMMA_CHANNEL]).gammaB;
			gammaSliderB.minimum = 0;
			gammaSliderB.maximum = 5;
			gammaSliderB.value = EffectGammaCorChannel(postEffects[GAMMA_CHANNEL]).gammaB;
			
			// GAMMA CORRECTION
			_window[GAMMA_CORRECTION] = new Window(m_parent, _posX2, _posY2, "Gamma Correction");
			_window[GAMMA_CORRECTION].hasMinimizeButton = true;
			_window[GAMMA_CORRECTION].height = 180;
			_window[GAMMA_CORRECTION].width = 200;
			_window[GAMMA_CORRECTION].visible = false;
			var gammaLabel:Label = new Label(_window[GAMMA_CORRECTION],5,5,"Gamma: ");
			var gammaSlider:HSlider = new HSlider(_window[GAMMA_CORRECTION],5, 20, function():void{
				EffectGammaCorrection(postEffects[GAMMA_CORRECTION]).gamma = gammaSlider.value;
				gammaLabel.text = "Gamma: "+ EffectGammaCorrection(postEffects[GAMMA_CORRECTION]).gamma;
				
			});
			gammaLabel.text = "Gamma: "+ EffectGammaCorrection(postEffects[GAMMA_CORRECTION]).gamma;
			gammaSlider.minimum = 0;
			gammaSlider.maximum = 5;
			gammaSlider.value = EffectGammaCorrection(postEffects[GAMMA_CORRECTION]).gamma;
			
			// PIXELATION
			_window[PIXELATION] = new Window(m_parent, _posX2, _posY2, "Pixelation");
			_window[PIXELATION].hasMinimizeButton = true;
			_window[PIXELATION].height = 180;
			_window[PIXELATION].width = 200;
			_window[PIXELATION].visible = false;
			
			var pixelW:Label = new Label(_window[PIXELATION],5,5,"Pixel Width: ");
			var pixelWSlider:HSlider = new HSlider(_window[PIXELATION],5, 20, function():void{
				EffectPixelation(postEffects[PIXELATION]).pixelWidth = pixelWSlider.value;
				pixelW.text = "Pixel Width: "+ EffectPixelation(postEffects[PIXELATION]).pixelWidth;
				
			});
			pixelW.text = "Pixel Width: "+ EffectPixelation(postEffects[PIXELATION]).pixelWidth;
			pixelWSlider.minimum = 0;
			pixelWSlider.maximum = 50;
			pixelWSlider.value = EffectPixelation(postEffects[PIXELATION]).pixelWidth;
			
			var pixelH:Label = new Label(_window[PIXELATION],5,35,"Pixel Height: ");
			var pixelHSlider:HSlider = new HSlider(_window[PIXELATION],5, 50, function():void{
				EffectPixelation(postEffects[PIXELATION]).pixelHeight = pixelHSlider.value;
				pixelH.text = "Pixel Height: "+ EffectPixelation(postEffects[PIXELATION]).pixelHeight;
				
			});
			pixelH.text = "Pixel Height: "+ EffectPixelation(postEffects[PIXELATION]).pixelHeight;
			pixelHSlider.minimum = 0;
			pixelHSlider.maximum = 50;
			pixelHSlider.value = EffectPixelation(postEffects[PIXELATION]).pixelHeight;
			
			//NOISE
			_window[NOISE] = new Window(m_parent, _posX2, _posY2, "Noise");
			_window[NOISE].hasMinimizeButton = true;
			_window[NOISE].height = 180;
			_window[NOISE].width = 200;
			_window[NOISE].visible = false;
			
			var namountL:Label = new Label(_window[NOISE],5,5,"Amount: ");
			var namountSlider:HSlider = new HSlider(_window[NOISE],5, 20, function():void{
				EffectNoise(postEffects[NOISE]).amount = namountSlider.value;
				namountL.text = "Amount: "+ EffectNoise(postEffects[NOISE]).amount;
				
			});
			namountL.text = "Amount: "+ EffectNoise(postEffects[NOISE]).amount;
			namountSlider.minimum = 0;
			namountSlider.maximum = 1;
			namountSlider.value = EffectNoise(postEffects[NOISE]).amount;
			
			
			// SWIRL
			_window[SWIRL] = new Window(m_parent, _posX2, _posY2, "Swirl");
			_window[SWIRL].hasMinimizeButton = true;
			_window[SWIRL].height = 180;
			_window[SWIRL].width = 200;
			_window[SWIRL].visible = false;
			
			new Label(_window[SWIRL], 5, 5, "Radius");
			var swirlRadiusSlider:HSlider = new HSlider(_window[SWIRL],5, 20, function():void{
				EffectSwirl(postEffects[SWIRL]).radius = swirlRadiusSlider.value;
			});
			swirlRadiusSlider.minimum = 0;
			swirlRadiusSlider.maximum = 1000;
			swirlRadiusSlider.value = EffectSwirl(postEffects[SWIRL]).radius;
			
			new Label(_window[SWIRL], 5, 35, "Angle");
			var swirlangleSlider:HSlider = new HSlider(_window[SWIRL],5, 50, function():void{
				EffectSwirl(postEffects[SWIRL]).angle = swirlangleSlider.value;
			});
			swirlangleSlider.minimum = 0;
			swirlangleSlider.maximum = 5;
			swirlangleSlider.value = EffectSwirl(postEffects[SWIRL]).angle;
			
			new Label(_window[SWIRL], 5, 65, "Effect");
			var swirleffectSlider:HSlider = new HSlider(_window[SWIRL],5, 80, function():void{
				EffectSwirl(postEffects[SWIRL]).effect = swirleffectSlider.value;
			});
			swirleffectSlider.minimum = 0;
			swirleffectSlider.maximum = 100;
			swirleffectSlider.value = EffectSwirl(postEffects[SWIRL]).effect;
			
			new Label(_window[SWIRL], 5, 95, "CenterX");
			var swirlCXSlider:HSlider = new HSlider(_window[SWIRL],5, 110, function():void{
				EffectSwirl(postEffects[SWIRL]).centerX = swirlCXSlider.value;
			});
			swirlCXSlider.minimum = 0;
			swirlCXSlider.maximum = 1000;
			swirlCXSlider.value = EffectSwirl(postEffects[SWIRL]).centerX;
			
			new Label(_window[SWIRL], 5, 125, "CenterY");
			var swirlCYSlider:HSlider = new HSlider(_window[SWIRL],5, 140, function():void{
				EffectSwirl(postEffects[SWIRL]).centerY = swirlCYSlider.value;
			});
			swirlCYSlider.minimum = 0;
			swirlCYSlider.maximum = 1000;
			swirlCYSlider.value = EffectSwirl(postEffects[SWIRL]).centerY;
			
			//THERMAL VISION
			
			_window[THERMAL_VISION] = new Window(m_parent, _posX2, _posY2, "Thermal Vision");
			_window[THERMAL_VISION].hasMinimizeButton = true;
			_window[THERMAL_VISION].height = 180;
			_window[THERMAL_VISION].width = 200;
			_window[THERMAL_VISION].visible = false;
			
			new Label(_window[THERMAL_VISION], 5, 5, "Color 0");
			var col0:ColorChooser = new ColorChooser(_window[THERMAL_VISION], 5, 20, 0x0000FF,function():void{
				var tmp:String = "0xFF"+col0.value;
				EffectThermalVision(postEffects[THERMAL_VISION]).color0.setColorUint(uint(tmp));
				//	trace(uint(col0.value));
			});
			
			col0.usePopup = true;
			
			new Label(_window[THERMAL_VISION], 5, 30, "Color 1");
			var col1:ColorChooser = new ColorChooser(_window[THERMAL_VISION], 5, 45, 0xFFFF00,function():void{
				var tmp:String = "0xFF"+col1.value;
				EffectThermalVision(postEffects[THERMAL_VISION]).color1.setColorUint(uint(tmp));
				//EffectThermalVision(postEffects[THERMAL_VISION]).color1.setColorUint(col1.value);
			});
			col1.usePopup = true;
			
			new Label(_window[THERMAL_VISION], 5, 55, "Color 2");
			var col2:ColorChooser = new ColorChooser(_window[THERMAL_VISION], 5, 70, 0xFF0000,function():void{
				var tmp:String = "0xFF"+col2.value;
				EffectThermalVision(postEffects[THERMAL_VISION]).color2.setColorUint(uint(tmp));
				//EffectThermalVision(postEffects[THERMAL_VISION]).color2.setColorUint(col2.value);
			});
			col2.usePopup = true;
			
			new Label(_window[THERMAL_VISION], 5, 85, "Threshold");
			var ttSlider:HSlider = new HSlider(_window[THERMAL_VISION],5, 100, function():void{
				EffectThermalVision(postEffects[THERMAL_VISION]).threshold = ttSlider.value;
				
			});
			ttSlider.minimum = 0;
			ttSlider.maximum = 2;
			ttSlider.value = EffectThermalVision(postEffects[THERMAL_VISION]).threshold;
			
			// VIBRANCE
			_window[VIBRANCE] = new Window(m_parent, _posX2, _posY2, "Vibrance");
			_window[VIBRANCE].hasMinimizeButton = true;
			_window[VIBRANCE].height = 180;
			_window[VIBRANCE].width = 200;
			_window[VIBRANCE].visible = false;
			
			var amountL:Label = new Label(_window[VIBRANCE],5,5,"Amount: ");
			var amountSlider:HSlider = new HSlider(_window[VIBRANCE],5, 20, function():void{
				EffectVibrance(postEffects[VIBRANCE]).amount = amountSlider.value;
				amountL.text = "Amount: "+ EffectVibrance(postEffects[VIBRANCE]).amount;
				
			});
			amountL.text = "Amount: "+ EffectVibrance(postEffects[VIBRANCE]).amount;
			amountSlider.minimum = -1;
			amountSlider.maximum = 1;
			amountSlider.value = EffectVibrance(postEffects[VIBRANCE]).amount;
			
			// DOT SCREEN
			_window[DOTSCREEN] = new Window(m_parent, _posX2, _posY2, "Dot Screen");
			_window[DOTSCREEN].hasMinimizeButton = true;
			_window[DOTSCREEN].height = 180;
			_window[DOTSCREEN].width = 200;
			_window[DOTSCREEN].visible = false;
			
			var bradiusL:Label = new Label(_window[DOTSCREEN],5,5,"Angle: ");
			var bradiusSlider:HSlider = new HSlider(_window[DOTSCREEN],5, 20, function():void{
				EffectDotScreen(postEffects[DOTSCREEN]).angle = bradiusSlider.value;
				bradiusL.text = "Angle: "+ EffectDotScreen(postEffects[DOTSCREEN]).angle;
				
			});
			bradiusL.text = "Angle: "+ EffectDotScreen(postEffects[DOTSCREEN]).angle;
			bradiusSlider.minimum = 0;
			bradiusSlider.maximum = 1.507;
			bradiusSlider.value = EffectDotScreen(postEffects[DOTSCREEN]).angle;
			
			var bstrengthL:Label = new Label(_window[DOTSCREEN],5,35,"Size: ");
			var bstrengthSlider:HSlider = new HSlider(_window[DOTSCREEN],5, 50, function():void{
				EffectDotScreen(postEffects[DOTSCREEN]).scale = bstrengthSlider.value;
				bstrengthL.text = "Size: "+ EffectDotScreen(postEffects[DOTSCREEN]).scale;
				
			});
			bstrengthL.text = "Size: "+ EffectDotScreen(postEffects[DOTSCREEN]).scale;
			bstrengthSlider.minimum = 3;
			bstrengthSlider.maximum = 20;
			bstrengthSlider.value = EffectDotScreen(postEffects[DOTSCREEN]).scale;
			
			var bcenterXL:Label = new Label(_window[DOTSCREEN],5,65,"Center X: ");
			var bcenterXSlider:HSlider = new HSlider(_window[DOTSCREEN],5, 80, function():void{
				EffectDotScreen(postEffects[DOTSCREEN]).centerX = bcenterXSlider.value;
				bcenterXL.text = "Center X: "+ EffectDotScreen(postEffects[DOTSCREEN]).centerX;
				
			});
			bcenterXL.text = "Center X: "+ EffectDotScreen(postEffects[DOTSCREEN]).centerX;
			bcenterXSlider.minimum = 0;
			bcenterXSlider.maximum = 800;
			bcenterXSlider.value = EffectDotScreen(postEffects[DOTSCREEN]).centerX;
			
			var bcenterYL:Label = new Label(_window[DOTSCREEN],5,95,"Center Y: ");
			var bcenterYSlider:HSlider = new HSlider(_window[DOTSCREEN],5, 110, function():void{
				EffectDotScreen(postEffects[DOTSCREEN]).centerY = bcenterYSlider.value;
				bcenterYL.text = "Center Y: "+ EffectDotScreen(postEffects[DOTSCREEN]).centerY;
				
			});
			bcenterYL.text = "Center Y: "+ EffectDotScreen(postEffects[DOTSCREEN]).centerY;
			bcenterYSlider.minimum = 0;
			bcenterYSlider.maximum = 800;
			bcenterYSlider.value = EffectDotScreen(postEffects[DOTSCREEN]).centerY;
			
			// LENS CIRCLE
			_window[LENS_CIRCLE] = new Window(m_parent, _posX2, _posY2, "Lens Circle");
			_window[LENS_CIRCLE].hasMinimizeButton = true;
			_window[LENS_CIRCLE].height = 180;
			_window[LENS_CIRCLE].width = 200;
			_window[LENS_CIRCLE].visible = false;
			
			var lensX:Label = new Label(_window[LENS_CIRCLE],5,5,"Lens X: ");
			var lensXSlider:HSlider = new HSlider(_window[LENS_CIRCLE],5, 20, function():void{
				EffectLensCircle(postEffects[LENS_CIRCLE]).lensX = lensXSlider.value;
				lensX.text = "Lens X: "+ EffectLensCircle(postEffects[LENS_CIRCLE]).lensX;
				
			});
			lensX.text = "Lens X: "+ EffectLensCircle(postEffects[LENS_CIRCLE]).lensX;
			lensXSlider.minimum = 0;
			lensXSlider.maximum = 5;
			lensXSlider.value = EffectLensCircle(postEffects[LENS_CIRCLE]).lensX;
			
			var lensY:Label = new Label(_window[LENS_CIRCLE],5,35,"Lens Y: ");
			var lensYSlider:HSlider= new HSlider(_window[LENS_CIRCLE],5, 50, function():void{
				EffectLensCircle(postEffects[LENS_CIRCLE]).lensY = lensYSlider.value;
				lensY.text = "Lens Y: "+ EffectLensCircle(postEffects[LENS_CIRCLE]).lensY;
				
			});
			lensY.text = "Lens Y: "+ EffectLensCircle(postEffects[LENS_CIRCLE]).lensY;
			lensYSlider.minimum = 0;
			lensYSlider.maximum = 5;
			lensYSlider.value = EffectLensCircle(postEffects[LENS_CIRCLE]).lensY;
			
			var centerX:Label = new Label(_window[LENS_CIRCLE],5,65,"Center X: ");
			var centerXSlider:HSlider = new HSlider(_window[LENS_CIRCLE],5, 80, function():void{
				EffectLensCircle(postEffects[LENS_CIRCLE]).centerX = centerXSlider.value;
				centerX.text = "Center X: "+ EffectLensCircle(postEffects[LENS_CIRCLE]).centerX;
				
			});
			centerX.text = "Center X: "+ EffectLensCircle(postEffects[LENS_CIRCLE]).centerX;
			centerXSlider.minimum = 0;
			centerXSlider.maximum = 1;
			centerXSlider.value = EffectLensCircle(postEffects[LENS_CIRCLE]).centerX;
			
			var centerY:Label = new Label(_window[LENS_CIRCLE],5,95,"Center X: ");
			var centerYSlider:HSlider = new HSlider(_window[LENS_CIRCLE],5, 110, function():void{
				EffectLensCircle(postEffects[LENS_CIRCLE]).centerY = centerYSlider.value;
				centerY.text = "Center Y: "+ EffectLensCircle(postEffects[LENS_CIRCLE]).centerY;
				
			});
			centerY.text = "Center Y: "+ EffectLensCircle(postEffects[LENS_CIRCLE]).centerY;
			centerYSlider.minimum = 0;
			centerYSlider.maximum = 1;
			centerYSlider.value = EffectLensCircle(postEffects[LENS_CIRCLE]).centerY;
			
			//RADIAL_BLUR
			_window[RADIAL_BLUR] = new Window(m_parent, _posX2, _posY2, "Radial Blur");
			_window[RADIAL_BLUR].hasMinimizeButton = true;
			_window[RADIAL_BLUR].height = 180;
			_window[RADIAL_BLUR].width = 200;
			_window[RADIAL_BLUR].visible = false;
			
			var rStrength:Label = new Label(_window[RADIAL_BLUR],5,5,"Strength: ");
			var rStrengthSlider:HSlider = new HSlider(_window[RADIAL_BLUR],5, 20, function():void{
				EffectRadialBlur(postEffects[RADIAL_BLUR]).sampleStrength = rStrengthSlider.value;
				rStrength.text = "Strength: "+ EffectRadialBlur(postEffects[RADIAL_BLUR]).sampleStrength;
				
			});
			rStrength.text = "Strength: "+ EffectRadialBlur(postEffects[RADIAL_BLUR]).sampleStrength;
			rStrengthSlider.minimum = 0;
			rStrengthSlider.maximum = 5;
			rStrengthSlider.value = EffectRadialBlur(postEffects[RADIAL_BLUR]).sampleStrength;
			
			var rdistL:Label = new Label(_window[RADIAL_BLUR],5,35,"Dist: ");
			var rdistSlider:HSlider = new HSlider(_window[RADIAL_BLUR],5, 50, function():void{
				EffectRadialBlur(postEffects[RADIAL_BLUR]).sampleDist = rdistSlider.value;
				rdistL.text = "Dist: "+ EffectRadialBlur(postEffects[RADIAL_BLUR]).sampleDist;
				
			});
			rdistL.text = "Dist: "+ EffectRadialBlur(postEffects[RADIAL_BLUR]).sampleDist;
			rdistSlider.minimum = 0;
			rdistSlider.maximum = 5;
			rdistSlider.value = EffectRadialBlur(postEffects[RADIAL_BLUR]).sampleDist;
			
			// NIGHT VISION
			_window[NIGHT_VISION] = new Window(m_parent, _posX2, _posY2, "Night Vision");
			_window[NIGHT_VISION].hasMinimizeButton = true;
			_window[NIGHT_VISION].height = 180;
			_window[NIGHT_VISION].width = 200;
			_window[NIGHT_VISION].visible = false;
			
			new Label(_window[NIGHT_VISION], 5, 5, "Effect Coverage");
			var covSlider:HSlider = new HSlider(_window[NIGHT_VISION],5, 20, function():void{
				EffectNightVision(postEffects[NIGHT_VISION]).effectCoverage = covSlider.value;
			});
			covSlider.minimum = 0;
			covSlider.maximum = 1;
			covSlider.value = EffectNightVision(postEffects[NIGHT_VISION]).effectCoverage;
			
			new Label(_window[NIGHT_VISION], 5, 35, "Color Amp");
			var ampSlider:HSlider = new HSlider(_window[NIGHT_VISION],5, 50, function():void{
				EffectNightVision(postEffects[NIGHT_VISION]).colorAmplifaction = ampSlider.value;
			});
			ampSlider.minimum = 0;
			ampSlider.maximum = 30;
			ampSlider.value = EffectNightVision(postEffects[NIGHT_VISION]).colorAmplifaction;
			
			new Label(_window[NIGHT_VISION], 5, 65, "Luminance Threshold");
			var lumSlider:HSlider = new HSlider(_window[NIGHT_VISION],5, 80, function():void{
				EffectNightVision(postEffects[NIGHT_VISION]).luminanceThreshold = lumSlider.value;
			});
			lumSlider.minimum = 0;
			lumSlider.maximum = 1;
			lumSlider.value = EffectNightVision(postEffects[NIGHT_VISION]).luminanceThreshold;
			
			new Label(_window[NIGHT_VISION], 5, 105, "Noise Randomize");
			var noiseRandSlider:HSlider = new HSlider(_window[NIGHT_VISION],5, 120, function():void{
				EffectNightVision(postEffects[NIGHT_VISION]).noiseRandomize = noiseRandSlider.value;
			});
			noiseRandSlider.minimum = 0;
			noiseRandSlider.maximum = 300;
			noiseRandSlider.value = EffectNightVision(postEffects[NIGHT_VISION]).noiseRandomize;
			
			// Scratched FIlm
			
			_window[SCRATCHED_FILM] = new Window(m_parent, _posX2, _posY2, "Scratched Film");
			_window[SCRATCHED_FILM].hasMinimizeButton = true;
			_window[SCRATCHED_FILM].height = 180;
			_window[SCRATCHED_FILM].width = 200;
			_window[SCRATCHED_FILM].visible = false;
			
			new Label(_window[SCRATCHED_FILM], 5, 5, "IS");
			var isSlider:HSlider = new HSlider(_window[SCRATCHED_FILM],5, 20, function():void{
				EffectScrathedFilm(postEffects[SCRATCHED_FILM]).IS = isSlider.value;
			});
			isSlider.minimum = 0;
			isSlider.maximum = 1;
			isSlider.value = EffectScrathedFilm(postEffects[SCRATCHED_FILM]).IS;
			
			new Label(_window[SCRATCHED_FILM], 5, 35, "Scratch Intensity");
			var sIntSlider:HSlider = new HSlider(_window[SCRATCHED_FILM],5, 50, function():void{
				EffectScrathedFilm(postEffects[SCRATCHED_FILM]).scratchIntensity = sIntSlider.value;
			});
			sIntSlider.minimum = 0;
			sIntSlider.maximum = 1;
			sIntSlider.value = EffectScrathedFilm(postEffects[SCRATCHED_FILM]).scratchIntensity;
			
			new Label(_window[SCRATCHED_FILM], 5, 65, "Speed 1");
			var speed1Slider:HSlider = new HSlider(_window[SCRATCHED_FILM],5, 80, function():void{
				EffectScrathedFilm(postEffects[SCRATCHED_FILM]).speed1 = speed1Slider.value;
			});
			speed1Slider.minimum = 0;
			speed1Slider.maximum = 1;
			speed1Slider.value = EffectScrathedFilm(postEffects[SCRATCHED_FILM]).speed1;
			
			new Label(_window[SCRATCHED_FILM], 5, 95, "Speed 2");
			var speed2Slider:HSlider = new HSlider(_window[SCRATCHED_FILM],5, 110, function():void{
				EffectScrathedFilm(postEffects[SCRATCHED_FILM]).speed2 = speed2Slider.value;
			});
			speed2Slider.minimum = 0;
			speed2Slider.maximum = 1;
			speed2Slider.value = EffectScrathedFilm(postEffects[SCRATCHED_FILM]).speed2;
			
		}
		
		public function update():void{
			if(currentEffect && (currentEffect is EffectScrathedFilm)){
				EffectScrathedFilm(currentEffect).timer += 0.01;
			}
		}
	}
}