package setup
{
	import com.yogurt3d.core.namespaces.YOGURT3D_INTERNAL;
	import com.yogurt3d.core.sceneobjects.Scene;
	import com.yogurt3d.core.sceneobjects.Scene3D;
	import com.yogurt3d.core.sceneobjects.scenetree.octree.OctScene;
	import com.yogurt3d.core.setup.SetupBase;
	import com.yogurt3d.presets.cameras.FreeFlightCamera;
	import com.yogurt3d.presets.cameras.TargetCamera;
	
	import flash.display.DisplayObjectContainer;

	public class TestSetup extends SetupBase
	{
		public function TestSetup(_parent:DisplayObjectContainer)
		{
			super( _parent );
			
			if( _parent.stage )
			{
				viewport.x = 0;
				viewport.y= 0;
				viewport.width = _parent.stage.stageWidth;
				viewport.height = _parent.stage.stageHeight;
			}else{
				viewport.x = 0;
				viewport.y= 0;
				viewport.width = _parent.width;
				viewport.height = _parent.height;
			}
			
			YOGURT3D_INTERNAL::scene = new Scene3D();
			
			YOGURT3D_INTERNAL::camera = new FreeFlightCamera(viewport);
			
			camera.frustum.setProjectionPerspective(55, viewport.width/viewport.height,1,4500 );
		}
		
		public function get scene():Scene3D{
			return YOGURT3D_INTERNAL::scene as Scene3D;
		}
		public function set scene(value:Scene3D):void{
			YOGURT3D_INTERNAL::scene = value;
		}
		
		public function get camera():FreeFlightCamera{
			return YOGURT3D_INTERNAL::camera as FreeFlightCamera;
		}
		
		public function set camera(value:FreeFlightCamera):void{
			YOGURT3D_INTERNAL::camera = value;
		}
	}
}