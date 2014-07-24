package d2api
{
   import d2components.GraphicContainer;
   import d2utils.UiModule;
   import d2components.Texture;
   
   public class UiApi extends Object
   {
      
      public function UiApi() {
         super();
      }
      
      public function destroy() : void {
      }
      
      public function loadUi(name:String, instanceName:String = null, params:* = null, strata:uint = 1, cacheName:String = null, replace:Boolean = false) : Object {
         return null;
      }
      
      public function loadUiInside(name:String, container:GraphicContainer, instanceName:String = null, params:* = null) : Object {
         return null;
      }
      
      public function unloadUi(instanceName:String = null) : void {
      }
      
      public function getUi(instanceName:String) : * {
         return null;
      }
      
      public function getUiInstances() : Object {
         return null;
      }
      
      public function getModuleList() : Object {
         return null;
      }
      
      public function getModule(moduleName:String, includeUnInitialized:Boolean = false) : UiModule {
         return null;
      }
      
      public function setModuleEnable(id:String, b:Boolean) : void {
      }
      
      public function addChild(target:Object, child:Object) : void {
      }
      
      public function me() : * {
         return null;
      }
      
      public function initDefaultBinds() : void {
      }
      
      public function addShortcutHook(shortcutName:String, hook:Function, lowPriority:Boolean = false) : void {
      }
      
      public function addComponentHook(target:GraphicContainer, hookName:String) : void {
      }
      
      public function bindApi(targetTexture:Texture, propertyName:String, value:*) : Boolean {
         return false;
      }
      
      public function createComponent(type:String, ... params) : GraphicContainer {
         return null;
      }
      
      public function createContainer(type:String, ... params) : * {
         return null;
      }
      
      public function createInstanceEvent(target:Object, instance:*) : Object {
         return null;
      }
      
      public function getEventClassName(event:String) : String {
         return null;
      }
      
      public function addInstanceEvent(event:Object) : void {
      }
      
      public function createUri(uri:String) : Object {
         return null;
      }
      
      public function showTooltip(data:*, target:*, autoHide:Boolean = false, name:String = "standard", point:uint = 0, relativePoint:uint = 2, offset:int = 3, tooltipMaker:String = null, script:Class = null, makerParam:Object = null, cacheName:String = null, mouseEnabled:Boolean = false, strata:int = 4, zoom:Number = 1, uiModuleName:String = "") : void {
      }
      
      public function hideTooltip(name:String = null) : void {
      }
      
      public function textTooltipInfo(content:String, css:String = null, cssClass:String = null, maxWidth:int = 400) : Object {
         return null;
      }
      
      public function getRadioGroupSelectedItem(rgName:String, me:Object) : Object {
         return null;
      }
      
      public function setRadioGroupSelectedItem(rgName:String, item:Object, me:Object) : void {
      }
      
      public function keyIsDown(keyCode:uint) : Boolean {
         return false;
      }
      
      public function keyIsUp(keyCode:uint) : Boolean {
         return false;
      }
      
      public function convertToTreeData(array:*) : Object {
         return null;
      }
      
      public function setFollowCursorUri(uri:*, lockX:Boolean = false, lockY:Boolean = false, xOffset:int = 0, yOffset:int = 0, scale:Number = 1) : void {
      }
      
      public function getFollowCursorUri() : Object {
         return null;
      }
      
      public function endDrag() : void {
      }
      
      public function preloadCss(url:String) : void {
      }
      
      public function getMouseX() : int {
         return 0;
      }
      
      public function getMouseY() : int {
         return 0;
      }
      
      public function getStageWidth() : int {
         return 0;
      }
      
      public function getStageHeight() : int {
         return 0;
      }
      
      public function getWindowWidth() : int {
         return 0;
      }
      
      public function getWindowHeight() : int {
         return 0;
      }
      
      public function getWindowScale() : Number {
         return 0;
      }
      
      public function setFullScreen(enabled:Boolean, onlyMaximize:Boolean = false) : void {
      }
      
      public function isFullScreen() : Boolean {
         return false;
      }
      
      public function useIME() : Boolean {
         return false;
      }
      
      public function buildOrnamentTooltipFrom(pTexture:Texture, pTarget:Object) : void {
      }
      
      public function getTextSize(pText:String, pCss:Object, pCssClass:String) : Object {
         return null;
      }
      
      public function setComponentMinMaxSize(component:GraphicContainer, minSize:Object, maxSize:Object) : void {
      }
      
      public function replaceParams(text:String, params:Object, replace:String = "%") : String {
         return null;
      }
      
      public function replaceKey(text:String) : String {
         return null;
      }
      
      public function getText(key:String, ... params) : String {
         return null;
      }
      
      public function getTextFromKey(key:uint, replace:String = "%", ... params) : String {
         return null;
      }
      
      public function processText(str:String, gender:String, singular:Boolean = true) : String {
         return null;
      }
      
      public function decodeText(str:String, params:Object) : String {
         return null;
      }
   }
}
