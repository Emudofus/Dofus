package d2components
{
   public class EntityDisplayer extends GraphicContainer
   {
      
      public function EntityDisplayer() {
         super();
      }
      
      public function get yOffset() : int {
         return new int();
      }
      
      public function set yOffset(v:int) : void {
      }
      
      public function get xOffset() : int {
         return new int();
      }
      
      public function set xOffset(v:int) : void {
      }
      
      public function get autoSize() : Boolean {
         return new Boolean();
      }
      
      public function set autoSize(v:Boolean) : void {
      }
      
      public function get useFade() : Boolean {
         return new Boolean();
      }
      
      public function set useFade(v:Boolean) : void {
      }
      
      public function get clearSubEntities() : Boolean {
         return new Boolean();
      }
      
      public function set clearSubEntities(v:Boolean) : void {
      }
      
      public function get clearAuras() : Boolean {
         return new Boolean();
      }
      
      public function set clearAuras(v:Boolean) : void {
      }
      
      public function get withoutMount() : Boolean {
         return new Boolean();
      }
      
      public function set withoutMount(v:Boolean) : void {
      }
      
      public function set look(rawLook:*) : void {
      }
      
      public function get look() : Object {
         return null;
      }
      
      public function set direction(n:uint) : void {
      }
      
      public function set animation(anim:String) : void {
      }
      
      public function set gotoAndStop(value:int) : void {
      }
      
      public function set staticDisplay(b:Boolean) : void {
      }
      
      public function get staticDisplay() : Boolean {
         return false;
      }
      
      public function get direction() : uint {
         return 0;
      }
      
      public function get animation() : String {
         return null;
      }
      
      public function set view(value:String) : void {
      }
      
      public function get useCache() : Boolean {
         return false;
      }
      
      public function set useCache(value:Boolean) : void {
      }
      
      public function update() : void {
      }
      
      public function updateMask() : void {
      }
      
      public function updateScaleAndOffsets() : void {
      }
      
      public function setAnimationAndDirection(anim:String, dir:uint) : void {
      }
      
      public function equipCharacter(list:Object, numDelete:int = 0) : void {
      }
      
      public function getSlotPosition(name:String) : Object {
         return null;
      }
      
      public function getSlotBounds(pSlotName:String) : Object {
         return null;
      }
      
      public function getEntityBounds() : Object {
         return null;
      }
      
      public function setColor(index:uint, color:uint) : void {
      }
      
      public function resetColor(index:uint) : void {
      }
   }
}
