package location
{
	import flash.utils.Dictionary;

	public class Location
	{
		public var models:Dictionary;
		public var textures:Dictionary;
		public var lightMaps:Dictionary;
		public var refMaps:Dictionary;
		public var specMaps:Dictionary;
		public var emmisiveMaps:Dictionary;
		public var specMasks:Dictionary;
		
		public var prioList:Vector.<LocObject>;
		public var name:String="";
		
		public function Location(_name:String)
		{
			models = new Dictionary;
			textures = new Dictionary;
			lightMaps = new Dictionary;
			specMaps = new Dictionary;
			refMaps = new Dictionary;
			emmisiveMaps = new Dictionary;
			specMasks = new Dictionary;
			prioList = null;
			name = _name;
		}
	}
}