package d2api
{
    import d2components.GraphicContainer;
    import d2utils.UiModule;
    import d2components.Texture;

    public class UiApi 
    {


        [Trusted]
        public function destroy():void
        {
        }

        [Untrusted]
        public function loadUi(name:String, instanceName:String=null, params:*=null, strata:uint=1, cacheName:String=null, replace:Boolean=false):Object
        {
            return (null);
        }

        [Untrusted]
        public function loadUiInside(name:String, container:GraphicContainer, instanceName:String=null, params:*=null):Object
        {
            return (null);
        }

        [Untrusted]
        public function unloadUi(instanceName:String=null):void
        {
        }

        [Untrusted]
        public function getUi(instanceName:String)
        {
            return (null);
        }

        [Untrusted]
        public function getUiInstances():Object
        {
            return (null);
        }

        [Untrusted]
        public function getModuleList():Object
        {
            return (null);
        }

        [Untrusted]
        public function getModule(moduleName:String, includeUnInitialized:Boolean=false):UiModule
        {
            return (null);
        }

        [Trusted]
        public function setModuleEnable(id:String, b:Boolean):void
        {
        }

        [Trusted]
        public function addChild(target:Object, child:Object):void
        {
        }

        [Untrusted]
        public function me()
        {
            return (null);
        }

        [Trusted]
        public function initDefaultBinds():void
        {
        }

        [Untrusted]
        public function addShortcutHook(shortcutName:String, hook:Function, lowPriority:Boolean=false):void
        {
        }

        [Untrusted]
        public function addComponentHook(target:GraphicContainer, hookName:String):void
        {
        }

        [Untrusted]
        public function removeComponentHook(target:GraphicContainer, hookName:String):void
        {
        }

        [Trusted]
        public function bindApi(targetTexture:Texture, propertyName:String, value:*):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function createComponent(type:String, ... params):GraphicContainer
        {
            return (null);
        }

        [Untrusted]
        public function createContainer(type:String, ... params)
        {
            return (null);
        }

        [Untrusted]
        public function createInstanceEvent(target:Object, instance:*):Object
        {
            return (null);
        }

        [Untrusted]
        public function getEventClassName(event:String):String
        {
            return (null);
        }

        [Untrusted]
        public function addInstanceEvent(event:Object):void
        {
        }

        [Untrusted]
        public function createUri(uri:String):Object
        {
            return (null);
        }

        [Untrusted]
        public function showTooltip(data:*, target:*, autoHide:Boolean=false, name:String="standard", point:uint=0, relativePoint:uint=2, offset:int=3, tooltipMaker:String=null, script:Class=null, makerParam:Object=null, cacheName:String=null, mouseEnabled:Boolean=false, strata:int=4, zoom:Number=1, uiModuleName:String=""):void
        {
        }

        [Untrusted]
        public function hideTooltip(name:String=null):void
        {
        }

        [Untrusted]
        public function textTooltipInfo(content:String, css:String=null, cssClass:String=null, maxWidth:int=400):Object
        {
            return (null);
        }

        [Untrusted]
        public function getRadioGroupSelectedItem(rgName:String, me:Object):Object
        {
            return (null);
        }

        [Untrusted]
        public function setRadioGroupSelectedItem(rgName:String, item:Object, me:Object):void
        {
        }

        [Untrusted]
        public function keyIsDown(keyCode:uint):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function keyIsUp(keyCode:uint):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function convertToTreeData(array:*):Object
        {
            return (null);
        }

        [Untrusted]
        public function setFollowCursorUri(uri:*, lockX:Boolean=false, lockY:Boolean=false, xOffset:int=0, yOffset:int=0, scale:Number=1):void
        {
        }

        [Untrusted]
        public function getFollowCursorUri():Object
        {
            return (null);
        }

        [Untrusted]
        public function endDrag():void
        {
        }

        [Untrusted]
        public function preloadCss(url:String):void
        {
        }

        [Untrusted]
        public function getMouseX():int
        {
            return (0);
        }

        [Untrusted]
        public function getMouseY():int
        {
            return (0);
        }

        [Untrusted]
        public function getStageWidth():int
        {
            return (0);
        }

        [Untrusted]
        public function getStageHeight():int
        {
            return (0);
        }

        [Untrusted]
        public function getWindowWidth():int
        {
            return (0);
        }

        [Untrusted]
        public function getWindowHeight():int
        {
            return (0);
        }

        [Untrusted]
        public function getWindowScale():Number
        {
            return (0);
        }

        [Trusted]
        public function setFullScreen(enabled:Boolean, onlyMaximize:Boolean=false):void
        {
        }

        [Untrusted]
        public function isFullScreen():Boolean
        {
            return (false);
        }

        [Trusted]
        public function setShortcutUsedToExitFullScreen(value:Boolean):void
        {
        }

        [Untrusted]
        public function useIME():Boolean
        {
            return (false);
        }

        [Trusted]
        public function buildOrnamentTooltipFrom(pTexture:Texture, pTarget:Object):void
        {
        }

        [Untrusted]
        public function getTextSize(pText:String, pCss:Object, pCssClass:String):Object
        {
            return (null);
        }

        [Trusted]
        public function setComponentMinMaxSize(component:GraphicContainer, minSize:Object, maxSize:Object):void
        {
        }

        [Untrusted]
        public function replaceParams(text:String, params:Object, replace:String="%"):String
        {
            return (null);
        }

        [Untrusted]
        public function replaceKey(text:String):String
        {
            return (null);
        }

        [Untrusted]
        public function getText(key:String, ... params):String
        {
            return (null);
        }

        [Untrusted]
        public function getTextFromKey(key:uint, replace:String="%", ... params):String
        {
            return (null);
        }

        [Untrusted]
        public function processText(str:String, gender:String, singular:Boolean=true):String
        {
            return (null);
        }

        [Untrusted]
        public function decodeText(str:String, params:Object):String
        {
            return (null);
        }


    }
}//package d2api

