package d2api
{
    import d2network.Version;
    import d2data.Server;
    import d2components.WebBrowser;

    public class SystemApi 
    {


        [Trusted]
        public function destroy():void
        {
        }

        [Untrusted]
        public function isInGame():Boolean
        {
            return (false);
        }

        [Trusted]
        public function isLoggingWithTicket():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function addHook(hookClass:Class, callback:Function):void
        {
        }

        [Untrusted]
        public function removeHook(hookClass:Class):void
        {
        }

        [Untrusted]
        public function createHook(name:String):void
        {
        }

        [Untrusted]
        public function dispatchHook(hookClass:Class, ... params):void
        {
        }

        [Untrusted]
        public function sendAction(action:Object):uint
        {
            return (0);
        }

        [Untrusted]
        public function log(level:uint, text:*):void
        {
        }

        [Trusted]
        public function setConfigEntry(sKey:String, sValue:*):void
        {
        }

        [Untrusted]
        public function getConfigEntry(sKey:String)
        {
            return (null);
        }

        [Trusted]
        public function getEnum(name:String):Object
        {
            return (null);
        }

        [Trusted]
        public function isEventMode():Boolean
        {
            return (false);
        }

        [Trusted]
        public function isCharacterCreationAllowed():Boolean
        {
            return (false);
        }

        [Trusted]
        public function getConfigKey(key:String)
        {
            return (null);
        }

        [Trusted]
        public function goToUrl(url:String):void
        {
        }

        [Trusted]
        public function getPlayerManager():Object
        {
            return (null);
        }

        [Trusted]
        public function getPort():uint
        {
            return (0);
        }

        [Trusted]
        public function setPort(port:uint):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function setData(name:String, value:*, shareWithAccount:Boolean=false):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getSetData(name:String, value:*, shareWithAccount:Boolean=false)
        {
            return (null);
        }

        [Untrusted]
        public function setQualityIsEnable():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function hasAir():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getAirVersion():uint
        {
            return (0);
        }

        [Untrusted]
        public function isAirVersionAvailable(version:uint):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function setAirVersion(version:uint):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getOs():String
        {
            return (null);
        }

        [Untrusted]
        public function getOsVersion():String
        {
            return (null);
        }

        [Untrusted]
        public function getCpu():String
        {
            return (null);
        }

        [Untrusted]
        public function getData(name:String, shareWithAccount:Boolean=false)
        {
            return (null);
        }

        [Untrusted]
        public function getOption(name:String, moduleName:String)
        {
            return (null);
        }

        [Untrusted]
        public function callbackHook(hook:Object, ... params):void
        {
        }

        [Untrusted]
        public function showWorld(b:Boolean):void
        {
        }

        [Untrusted]
        public function worldIsVisible():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getServerStatus():uint
        {
            return (0);
        }

        [Trusted]
        public function getConsoleAutoCompletion(cmd:String, server:Boolean):String
        {
            return (null);
        }

        [Trusted]
        public function getAutoCompletePossibilities(cmd:String, server:Boolean=false):Object
        {
            return (null);
        }

        [Trusted]
        public function getAutoCompletePossibilitiesOnParam(cmd:String, server:Boolean=false, paramIndex:uint=0, currentParams:Object=null):Object
        {
            return (null);
        }

        [Trusted]
        public function getCmdHelp(cmd:String, server:Boolean=false):String
        {
            return (null);
        }

        [Untrusted]
        public function startChrono(label:String):void
        {
        }

        [Untrusted]
        public function stopChrono():void
        {
        }

        [Trusted]
        public function hasAdminCommand(cmd:String):Boolean
        {
            return (false);
        }

        [Trusted]
        public function addEventListener(listener:Function, name:String, frameRate:uint=25):void
        {
        }

        [Trusted]
        public function removeEventListener(listener:Function):void
        {
        }

        [Trusted]
        public function disableWorldInteraction(pTotal:Boolean=true):void
        {
        }

        [Trusted]
        public function enableWorldInteraction():void
        {
        }

        [Trusted]
        public function setFrameRate(f:uint):void
        {
        }

        [Trusted]
        public function hasWorldInteraction():Boolean
        {
            return (false);
        }

        [Trusted]
        public function hasRight():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function isFightContext():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getEntityLookFromString(s:String):Object
        {
            return (null);
        }

        [Untrusted]
        public function getCurrentVersion():Version
        {
            return (null);
        }

        [Untrusted]
        public function getBuildType():uint
        {
            return (0);
        }

        [Untrusted]
        public function getCurrentLanguage():String
        {
            return (null);
        }

        [Trusted]
        public function clearCache(pSelective:Boolean=false):void
        {
        }

        [Trusted]
        public function reset():void
        {
        }

        [Untrusted]
        public function getCurrentServer():Server
        {
            return (null);
        }

        [Trusted]
        public function getGroundCacheSize():Number
        {
            return (0);
        }

        [Trusted]
        public function clearGroundCache():void
        {
        }

        [Trusted]
        public function zoom(value:Number):void
        {
        }

        [Trusted]
        public function getCurrentZoom():Number
        {
            return (0);
        }

        [Trusted]
        public function goToThirdPartyLogin(target:WebBrowser):void
        {
        }

        [Trusted]
        public function goToOgrinePortal(target:WebBrowser):void
        {
        }

        [Trusted]
        public function openWebModalOgrinePortal(jsCallback:Function=null):void
        {
        }

        [Trusted]
        public function goToAnkaBoxPortal(target:WebBrowser):void
        {
        }

        [Trusted]
        public function goToAnkaBoxLastMessage(target:WebBrowser):void
        {
        }

        [Trusted]
        public function goToAnkaBoxSend(target:WebBrowser, userId:int):void
        {
        }

        [Trusted]
        public function goToSupportFAQ(faqURL:String):void
        {
        }

        [Trusted]
        public function goToChangelogPortal(target:WebBrowser):void
        {
        }

        [Trusted]
        public function goToCheckLink(url:String, sender:uint, senderName:String):void
        {
        }

        [Trusted]
        public function refreshUrl(target:WebBrowser, domain:uint=0):void
        {
        }

        [Trusted]
        public function execServerCmd(cmd:String):void
        {
        }

        [Trusted]
        public function mouseZoom(zoomIn:Boolean=true):void
        {
        }

        [Trusted]
        public function resetZoom():void
        {
        }

        [Trusted]
        public function getMaxZoom():uint
        {
            return (0);
        }

        [Trusted]
        public function optimize():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function hasPart(partName:String):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function hasUpdaterConnection():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function isDownloading():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function isStreaming():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function isDevMode():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function isDownloadFinished():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function notifyUser(always:Boolean):void
        {
        }

        [Untrusted]
        public function setGameAlign(align:String):void
        {
        }

        [Untrusted]
        public function getGameAlign():String
        {
            return (null);
        }

        [Untrusted]
        public function getDirectoryContent(path:String="."):Object
        {
            return (null);
        }

        [Trusted]
        public function getAccountId(playerName:String):int
        {
            return (0);
        }

        [Untrusted]
        public function getIsAnkaBoxEnabled():Boolean
        {
            return (false);
        }

        [Trusted]
        public function getAdminStatus():int
        {
            return (0);
        }

        [Untrusted]
        public function getObjectVariables(o:Object, onlyVar:Boolean=false, useCache:Boolean=false):Object
        {
            return (null);
        }

        [Untrusted]
        public function getNewDynamicSecureObject():Object
        {
            return (null);
        }

        [Trusted]
        public function sendStatisticReport(key:String, value:String):Boolean
        {
            return (false);
        }

        [Trusted]
        public function isStatisticReported(key:String):Boolean
        {
            return (false);
        }

        [Trusted]
        public function getNickname():String
        {
            return (null);
        }

        [Trusted]
        public function copyToClipboard(val:String):void
        {
        }

        [Trusted]
        public function getLaunchArgs():String
        {
            return (null);
        }

        [Trusted]
        public function getPartnerInfo():String
        {
            return (null);
        }

        [Trusted]
        public function toggleModuleInstaller():void
        {
        }

        [Trusted]
        public function isUpdaterVersion2OrUnknown():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function isKeyDown(keyCode:uint):Boolean
        {
            return (false);
        }

        [Trusted]
        public function isGuest():Boolean
        {
            return (false);
        }

        [Trusted]
        public function isInForcedGuestMode():Boolean
        {
            return (false);
        }

        [Trusted]
        public function convertGuestAccount():void
        {
        }

        [Trusted]
        public function getGiftList():Object
        {
            return (null);
        }

        [Trusted]
        public function getCharaListMinusDeadPeople():Object
        {
            return (null);
        }


    }
}//package d2api

