package d2components
{
   public class MapViewer extends GraphicContainer
   {
      
      public function MapViewer() {
         super();
      }
      
      public function get mapWidth() : Number {
         return new Number();
      }
      
      public function set mapWidth(v:Number) : void {
      }
      
      public function get mapHeight() : Number {
         return new Number();
      }
      
      public function set mapHeight(v:Number) : void {
      }
      
      public function get origineX() : int {
         return new int();
      }
      
      public function set origineX(v:int) : void {
      }
      
      public function get origineY() : int {
         return new int();
      }
      
      public function set origineY(v:int) : void {
      }
      
      public function get maxScale() : Number {
         return new Number();
      }
      
      public function set maxScale(v:Number) : void {
      }
      
      public function get minScale() : Number {
         return new Number();
      }
      
      public function set minScale(v:Number) : void {
      }
      
      public function get startScale() : Number {
         return new Number();
      }
      
      public function set startScale(v:Number) : void {
      }
      
      public function get roundCornerRadius() : uint {
         return new uint();
      }
      
      public function set roundCornerRadius(v:uint) : void {
      }
      
      public function get enabledDrag() : Boolean {
         return new Boolean();
      }
      
      public function set enabledDrag(v:Boolean) : void {
      }
      
      public function get autoSizeIcon() : Boolean {
         return new Boolean();
      }
      
      public function set autoSizeIcon(v:Boolean) : void {
      }
      
      public function get gridLineThickness() : Number {
         return new Number();
      }
      
      public function set gridLineThickness(v:Number) : void {
      }
      
      public function get mapContainerBounds() : Object {
         return null;
      }
      
      public function get finalized() : Boolean {
         return false;
      }
      
      public function set finalized(b:Boolean) : void {
      }
      
      public function get showGrid() : Boolean {
         return false;
      }
      
      public function set showGrid(b:Boolean) : void {
      }
      
      public function get isDragging() : Boolean {
         return false;
      }
      
      public function get visibleMaps() : Object {
         return null;
      }
      
      public function get currentMouseMapX() : int {
         return 0;
      }
      
      public function get currentMouseMapY() : int {
         return 0;
      }
      
      public function get mapBounds() : Object {
         return null;
      }
      
      public function set mapAlpha(value:Number) : void {
      }
      
      public function get mapPixelPosition() : Object {
         return null;
      }
      
      public function get zoomFactor() : Number {
         return 0;
      }
      
      public function get zoomStep() : Number {
         return 0;
      }
      
      public function get zoomLevels() : Object {
         return null;
      }
      
      public function finalize() : void {
      }
      
      public function addLayer(name:String) : void {
      }
      
      public function addIcon(layer:String, id:String, uri:*, x:int, y:int, scale:Number = 1, legend:String = null, follow:Boolean = false, color:int = -1, canBeGrouped:Boolean = true) : Object {
         return null;
      }
      
      public function addAreaShape(layer:String, id:String, coordList:Object, lineColor:uint = 0, lineAlpha:Number = 1, fillColor:uint = 0, fillAlpha:Number = 0.4, thickness:int = 4) : Object {
         return null;
      }
      
      public function areaShapeColorTransform(me:Object, duration:int, rM:Number = 1, gM:Number = 1, bM:Number = 1, aM:Number = 1, rO:Number = 0, gO:Number = 0, bO:Number = 0, aO:Number = 0) : void {
      }
      
      public function getMapElement(id:String) : Object {
         return null;
      }
      
      public function getMapElementsByLayer(layerId:String) : Object {
         return null;
      }
      
      public function removeMapElement(me:Object) : void {
      }
      
      public function updateMapElements() : void {
      }
      
      public function showLayer(name:String, display:Boolean = true) : void {
      }
      
      public function moveToPixel(x:int, y:int, zoomFactor:Number) : void {
      }
      
      public function moveTo(x:Number, y:Number, width:uint = 1, height:uint = 1, center:Boolean = true, autoZoom:Boolean = true) : void {
      }
      
      public function zoom(scale:Number, coord:Object = null) : void {
      }
      
      public function addMap(zoom:Number, src:String, unscaleWitdh:uint, unscaleHeight:uint, chunckWidth:uint, chunckHeight:uint) : void {
      }
      
      public function removeAllMap() : void {
      }
      
      public function getOrigineFromPos(x:int, y:int) : Object {
         return null;
      }
      
      public function set useFlagCursor(pValue:Boolean) : void {
      }
      
      public function get useFlagCursor() : Boolean {
         return false;
      }
      
      public function get allChunksLoaded() : Boolean {
         return false;
      }
   }
}
