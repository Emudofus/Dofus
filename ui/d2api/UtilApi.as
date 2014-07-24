package d2api
{
   import d2network.GameContextActorInformations;
   
   public class UtilApi extends Object
   {
      
      public function UtilApi() {
         super();
      }
      
      public function destroy() : void {
      }
      
      public function callWithParameters(method:Function, parameters:Object) : void {
      }
      
      public function callConstructorWithParameters(callClass:Class, parameters:Object) : * {
         return null;
      }
      
      public function callRWithParameters(method:Function, parameters:Object) : * {
         return null;
      }
      
      public function kamasToString(kamas:Number, unit:String = "-") : String {
         return null;
      }
      
      public function formateIntToString(val:Number) : String {
         return null;
      }
      
      public function stringToKamas(string:String, unit:String = "-") : int {
         return 0;
      }
      
      public function getTextWithParams(textId:int, params:Object, replace:String = "%") : String {
         return null;
      }
      
      public function applyTextParams(pText:String, pParams:Object, pReplace:String = "%") : String {
         return null;
      }
      
      public function noAccent(str:String) : String {
         return null;
      }
      
      public function changeColor(obj:Object, color:Number, depth:int, unColor:Boolean = false) : void {
      }
      
      public function sortOnString(list:*, field:String = "") : void {
      }
      
      public function sort(target:*, field:String, ascendand:Boolean = true, isNumeric:Boolean = false) : * {
         return null;
      }
      
      public function filter(target:*, pattern:*, field:String) : * {
         return null;
      }
      
      public function getTiphonEntityLook(pEntityId:int) : Object {
         return null;
      }
      
      public function getRealTiphonEntityLook(pEntityId:int, pWithoutMount:Boolean = false) : Object {
         return null;
      }
      
      public function getLookFromContext(pEntityId:int, pForceCreature:Boolean = false) : Object {
         return null;
      }
      
      public function getLookFromContextInfos(pInfos:GameContextActorInformations, pForceCreature:Boolean = false) : Object {
         return null;
      }
      
      public function isCreature(pEntityId:int) : Boolean {
         return false;
      }
      
      public function isCreatureFromLook(pLook:Object) : Boolean {
         return false;
      }
      
      public function isIncarnation(pEntityId:int) : Boolean {
         return false;
      }
      
      public function isIncarnationFromLook(pLook:Object) : Boolean {
         return false;
      }
      
      public function isCreatureMode() : Boolean {
         return false;
      }
      
      public function getCreatureLook(pEntityId:int) : Object {
         return null;
      }
   }
}
