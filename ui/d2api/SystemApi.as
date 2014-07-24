package d2api
{
   import d2network.Version;
   import d2data.Server;
   import d2components.WebBrowser;
   
   public class SystemApi extends Object
   {
      
      public function SystemApi() {
         super();
      }
      
      public function destroy() : void {
      }
      
      public function isInGame() : Boolean {
         return false;
      }
      
      public function addHook(hookClass:Class, callback:Function) : void {
      }
      
      public function removeHook(hookClass:Class) : void {
      }
      
      public function createHook(name:String) : void {
      }
      
      public function dispatchHook(hookClass:Class, ... params) : void {
      }
      
      public function sendAction(action:Object) : uint {
         return 0;
      }
      
      public function log(level:uint, text:*) : void {
      }
      
      public function setConfigEntry(sKey:String, sValue:*) : void {
      }
      
      public function getConfigEntry(sKey:String) : * {
         return null;
      }
      
      public function getEnum(name:String) : Object {
         return null;
      }
      
      public function isEventMode() : Boolean {
         return false;
      }
      
      public function isCharacterCreationAllowed() : Boolean {
         return false;
      }
      
      public function getConfigKey(key:String) : * {
         return null;
      }
      
      public function goToUrl(url:String) : void {
      }
      
      public function getPlayerManager() : Object {
         return null;
      }
      
      public function getPort() : uint {
         return 0;
      }
      
      public function setPort(port:uint) : Boolean {
         return false;
      }
      
      public function setData(name:String, value:*, shareWithAccount:Boolean = false) : Boolean {
         return false;
      }
      
      public function getSetData(name:String, value:*, shareWithAccount:Boolean = false) : * {
         return null;
      }
      
      public function setQualityIsEnable() : Boolean {
         return false;
      }
      
      public function hasAir() : Boolean {
         return false;
      }
      
      public function getAirVersion() : uint {
         return 0;
      }
      
      public function isAirVersionAvailable(version:uint) : Boolean {
         return false;
      }
      
      public function setAirVersion(version:uint) : Boolean {
         return false;
      }
      
      public function getOs() : String {
         return null;
      }
      
      public function getOsVersion() : String {
         return null;
      }
      
      public function getCpu() : String {
         return null;
      }
      
      public function getData(name:String, shareWithAccount:Boolean = false) : * {
         return null;
      }
      
      public function getOption(name:String, moduleName:String) : * {
         return null;
      }
      
      public function callbackHook(hook:Object, ... params) : void {
      }
      
      public function showWorld(b:Boolean) : void {
      }
      
      public function worldIsVisible() : Boolean {
         return false;
      }
      
      public function getConsoleAutoCompletion(cmd:String, server:Boolean) : String {
         return null;
      }
      
      public function getAutoCompletePossibilities(cmd:String, server:Boolean = false) : Object {
         return null;
      }
      
      public function getAutoCompletePossibilitiesOnParam(cmd:String, server:Boolean = false, paramIndex:uint = 0, currentParams:Object = null) : Object {
         return null;
      }
      
      public function getCmdHelp(cmd:String, server:Boolean = false) : String {
         return null;
      }
      
      public function startChrono(label:String) : void {
      }
      
      public function stopChrono() : void {
      }
      
      public function hasAdminCommand(cmd:String) : Boolean {
         return false;
      }
      
      public function addEventListener(listener:Function, name:String, frameRate:uint = 25) : void {
      }
      
      public function removeEventListener(listener:Function) : void {
      }
      
      public function disableWorldInteraction(pTotal:Boolean = true) : void {
      }
      
      public function enableWorldInteraction() : void {
      }
      
      public function setFrameRate(f:uint) : void {
      }
      
      public function hasWorldInteraction() : Boolean {
         return false;
      }
      
      public function hasRight() : Boolean {
         return false;
      }
      
      public function isFightContext() : Boolean {
         return false;
      }
      
      public function getEntityLookFromString(s:String) : Object {
         return null;
      }
      
      public function getCurrentVersion() : Version {
         return null;
      }
      
      public function getBuildType() : uint {
         return 0;
      }
      
      public function getCurrentLanguage() : String {
         return null;
      }
      
      public function clearCache(pSelective:Boolean = false) : void {
      }
      
      public function reset() : void {
      }
      
      public function getCurrentServer() : Server {
         return null;
      }
      
      public function getGroundCacheSize() : Number {
         return 0;
      }
      
      public function clearGroundCache() : void {
      }
      
      public function zoom(value:Number) : void {
      }
      
      public function getCurrentZoom() : Number {
         return 0;
      }
      
      public function goToThirdPartyLogin(target:WebBrowser) : void {
      }
      
      public function goToOgrinePortal(target:WebBrowser) : void {
      }
      
      public function goToAnkaBoxPortal(target:WebBrowser) : void {
      }
      
      public function goToAnkaBoxLastMessage(target:WebBrowser) : void {
      }
      
      public function goToAnkaBoxSend(target:WebBrowser, userId:int) : void {
      }
      
      public function goToSupportFAQ(faqURL:String) : void {
      }
      
      public function goToChangelogPortal(target:WebBrowser) : void {
      }
      
      public function goToCheckLink(url:String, sender:uint, senderName:String) : void {
      }
      
      public function refreshUrl(target:WebBrowser, domain:uint = 0) : void {
      }
      
      public function execServerCmd(cmd:String) : void {
      }
      
      public function mouseZoom(zoomIn:Boolean = true) : void {
      }
      
      public function resetZoom() : void {
      }
      
      public function getMaxZoom() : uint {
         return 0;
      }
      
      public function optimize() : Boolean {
         return false;
      }
      
      public function hasPart(partName:String) : Boolean {
         return false;
      }
      
      public function hasUpdaterConnection() : Boolean {
         return false;
      }
      
      public function isDownloading() : Boolean {
         return false;
      }
      
      public function isStreaming() : Boolean {
         return false;
      }
      
      public function isDevMode() : Boolean {
         return false;
      }
      
      public function isDownloadFinished() : Boolean {
         return false;
      }
      
      public function notifyUser(always:Boolean) : void {
      }
      
      public function setGameAlign(align:String) : void {
      }
      
      public function getGameAlign() : String {
         return null;
      }
      
      public function getDirectoryContent(path:String = ".") : Object {
         return null;
      }
      
      public function getAccountId(playerName:String) : int {
         return 0;
      }
      
      public function getIsAnkaBoxEnabled() : Boolean {
         return false;
      }
      
      public function getAdminStatus() : int {
         return 0;
      }
      
      public function getObjectVariables(o:Object, onlyVar:Boolean = false, useCache:Boolean = false) : Object {
         return null;
      }
      
      public function getNewDynamicSecureObject() : Object {
         return null;
      }
      
      public function sendStatisticReport(key:String, value:String) : Boolean {
         return false;
      }
      
      public function isStatisticReported(key:String) : Boolean {
         return false;
      }
      
      public function getNickname() : String {
         return null;
      }
      
      public function copyToClipboard(val:String) : void {
      }
      
      public function getLaunchArgs() : String {
         return null;
      }
      
      public function getPartnerInfo() : String {
         return null;
      }
      
      public function toggleModuleInstaller() : void {
      }
      
      public function isUpdaterVersion2OrUnknown() : Boolean {
         return false;
      }
      
      public function isKeyDown(keyCode:uint) : Boolean {
         return false;
      }
   }
}
