package d2components
{
   import flash.display.Sprite;
   
   public class GraphicContainer extends D2Sprite
   {
      
      public function GraphicContainer() {
         super();
      }
      
      public function get minSize() : Object {
         return new Object();
      }
      
      public function set minSize(v:Object) : void {
      }
      
      public function get maxSize() : Object {
         return new Object();
      }
      
      public function set maxSize(v:Object) : void {
      }
      
      public function get customUnicName() : String {
         return null;
      }
      
      public function set dropValidator(dv:Function) : void {
      }
      
      public function get dropValidator() : Function {
         return null;
      }
      
      public function set removeDropSource(rds:Function) : void {
      }
      
      public function get removeDropSource() : Function {
         return null;
      }
      
      public function set processDrop(pd:Function) : void {
      }
      
      public function get processDrop() : Function {
         return null;
      }
      
      public function focus() : void {
      }
      
      public function get hasFocus() : Boolean {
         return false;
      }
      
      public function get scale() : Number {
         return 0;
      }
      
      public function set scale(nScale:Number) : void {
      }
      
      public function get contentWidth() : Number {
         return 0;
      }
      
      public function get contentHeight() : Number {
         return 0;
      }
      
      public function get anchorY() : Number {
         return 0;
      }
      
      public function get anchorX() : Number {
         return 0;
      }
      
      public function set bgColor(nColor:int) : void {
      }
      
      public function get bgColor() : int {
         return 0;
      }
      
      public function set bgAlpha(nAlpha:Number) : void {
      }
      
      public function get bgAlpha() : Number {
         return 0;
      }
      
      public function set borderColor(color:int) : void {
      }
      
      public function get borderColor() : int {
         return 0;
      }
      
      public function set bgCornerRadius(value:uint) : void {
      }
      
      public function get bgCornerRadius() : uint {
         return 0;
      }
      
      public function set luminosity(nColor:Number) : void {
      }
      
      public function get luminosity() : Number {
         return 0;
      }
      
      public function set linkedTo(sUiComponent:String) : void {
      }
      
      public function get linkedTo() : String {
         return null;
      }
      
      public function set shadowColor(nColor:int) : void {
      }
      
      public function get shadowColor() : int {
         return 0;
      }
      
      public function get topParent() : Object {
         return null;
      }
      
      public function setAdvancedGlow(nColor:uint, nAlpha:Number = 1, nBlurX:Number = 6.0, nBlurY:Number = 6.0, nStrength:Number = 2) : void {
      }
      
      public function clearFilters() : void {
      }
      
      public function getStrata(nStrata:uint) : Sprite {
         return null;
      }
      
      public function set dynamicPosition(bool:Boolean) : void {
      }
      
      public function get dynamicPosition() : Boolean {
         return false;
      }
      
      public function set disabled(bool:Boolean) : void {
      }
      
      public function get disabled() : Boolean {
         return false;
      }
      
      public function set softDisabled(bool:Boolean) : void {
      }
      
      public function get softDisabled() : Boolean {
         return false;
      }
      
      public function set greyedOut(bool:Boolean) : void {
      }
      
      public function get greyedOut() : Boolean {
         return false;
      }
      
      public function get depths() : Object {
         return null;
      }
      
      public function set handCursor(bValue:Boolean) : void {
      }
      
      public function getStageRect() : Object {
         return null;
      }
      
      public function remove() : void {
      }
      
      public function addContent(child:GraphicContainer, index:int = -1) : GraphicContainer {
         return null;
      }
      
      public function removeFromParent() : void {
      }
      
      public function getParent() : GraphicContainer {
         return null;
      }
      
      public function getUi() : Object {
         return null;
      }
      
      public function setUi(ui:Object, key:Object) : void {
      }
      
      public function getTopParent(d:Object) : Object {
         return null;
      }
      
      public function startResize() : void {
      }
      
      public function endResize() : void {
      }
      
      public function slide(endX:int, endY:int, time:int) : void {
      }
      
      public function free() : void {
      }
   }
}
