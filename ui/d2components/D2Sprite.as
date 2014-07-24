package d2components
{
   import flash.events.EventDispatcher;
   import flash.display.DisplayObject;
   import flash.geom.Transform;
   import flash.display.DisplayObjectContainer;
   
   public class D2Sprite extends EventDispatcher
   {
      
      public function D2Sprite() {
         super();
      }
      
      public function addChild(child:*) : DisplayObject {
         return null;
      }
      
      public function get isNull() : Boolean {
         return false;
      }
      
      public function get numChildren() : uint {
         return 0;
      }
      
      public function get name() : String {
         return null;
      }
      
      public function set name(n:String) : void {
      }
      
      public function get transform() : Transform {
         return null;
      }
      
      public function set transform(t:Transform) : void {
      }
      
      public function get mask() : * {
         return null;
      }
      
      public function set mask(t:*) : void {
      }
      
      public function get cacheAsBitmap() : Boolean {
         return false;
      }
      
      public function set cacheAsBitmap(b:Boolean) : void {
      }
      
      public function get useHandCursor() : Boolean {
         return false;
      }
      
      public function set useHandCursor(b:Boolean) : void {
      }
      
      public function get buttonMode() : Boolean {
         return false;
      }
      
      public function set buttonMode(b:Boolean) : void {
      }
      
      public function get tabEnabled() : Boolean {
         return false;
      }
      
      public function set tabEnabled(b:Boolean) : void {
      }
      
      public function get mouseEnabled() : Boolean {
         return false;
      }
      
      public function set mouseEnabled(b:Boolean) : void {
      }
      
      public function get mouseChildren() : Boolean {
         return false;
      }
      
      public function set mouseChildren(b:Boolean) : void {
      }
      
      public function get mouseX() : Number {
         return 0;
      }
      
      public function get mouseY() : Number {
         return 0;
      }
      
      public function get visible() : Boolean {
         return false;
      }
      
      public function set visible(b:Boolean) : void {
      }
      
      public function get rotation() : Number {
         return 0;
      }
      
      public function set rotation(value:Number) : void {
      }
      
      public function get scaleX() : Number {
         return 0;
      }
      
      public function set scaleX(value:Number) : void {
      }
      
      public function get scaleY() : Number {
         return 0;
      }
      
      public function set scaleY(value:Number) : void {
      }
      
      public function get width() : Number {
         return 0;
      }
      
      public function set width(value:Number) : void {
      }
      
      public function get height() : Number {
         return 0;
      }
      
      public function set height(value:Number) : void {
      }
      
      public function get x() : Number {
         return 0;
      }
      
      public function set x(value:Number) : void {
      }
      
      public function get y() : Number {
         return 0;
      }
      
      public function set y(value:Number) : void {
      }
      
      public function get alpha() : Number {
         return 0;
      }
      
      public function set alpha(value:Number) : void {
      }
      
      public function get filters() : Array {
         return null;
      }
      
      public function set filters(value:Array) : void {
      }
      
      public function get parent() : DisplayObjectContainer {
         return null;
      }
      
      public function getChildByName(name:String) : GraphicContainer {
         return null;
      }
      
      public function removeChild(target:*) : * {
         return null;
      }
      
      public function startDrag(lockCenter:Boolean = false, bounds:Object = null) : void {
      }
      
      public function stopDrag() : void {
      }
   }
}
