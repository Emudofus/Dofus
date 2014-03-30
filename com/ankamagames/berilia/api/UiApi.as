package com.ankamagames.berilia.api
{
   import com.ankamagames.berilia.interfaces.IApi;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.utils.errors.BeriliaError;
   import com.ankamagames.berilia.utils.errors.ApiError;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.jerakine.handlers.FocusHandler;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import __AS3__.vec.*;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.berilia.BeriliaConstants;
   import com.ankamagames.berilia.managers.BindsManager;
   import com.ankamagames.berilia.types.shortcut.Shortcut;
   import com.ankamagames.berilia.types.listener.GenericListener;
   import com.ankamagames.jerakine.utils.memory.WeakReference;
   import com.ankamagames.berilia.types.event.InstanceEvent;
   import com.ankamagames.berilia.managers.UIEventManager;
   import com.ankamagames.berilia.components.Texture;
   import flash.display.DisplayObject;
   import com.ankamagames.berilia.components.ComponentInternalAccessor;
   import com.ankamagames.jerakine.utils.misc.CallWithParameters;
   import flash.utils.getDefinitionByName;
   import com.ankamagames.berilia.enums.EventEnums;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.berilia.interfaces.IRadioItem;
   import com.ankamagames.berilia.types.data.RadioGroup;
   import com.ankamagames.jerakine.utils.display.KeyPoll;
   import com.ankamagames.berilia.types.data.TreeData;
   import com.ankamagames.berilia.types.data.LinkedCursorData;
   import flash.geom.Point;
   import com.ankamagames.berilia.managers.LinkedCursorSpriteManager;
   import com.ankamagames.berilia.types.data.SlotDragAndDropData;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.managers.CssManager;
   import flash.geom.Rectangle;
   import flash.display.MovieClip;
   import flash.display.DisplayObjectContainer;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   
   public class UiApi extends Object implements IApi
   {
      
      public function UiApi() {
         this.oldTextureBounds = new Rectangle();
         super();
         MEMORY_LOG[this] = 1;
      }
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      public static const _log:Logger = Log.getLogger(getQualifiedClassName(UiApi));
      
      private static var _label:Label;
      
      private var _module:UiModule;
      
      private var _currentUi:UiRootContainer;
      
      public function set module(value:UiModule) : void {
         if(!this._module)
         {
            this._module = value;
         }
      }
      
      public function set currentUi(value:UiRootContainer) : void {
         if(!this._currentUi)
         {
            this._currentUi = value;
         }
      }
      
      public function destroy() : void {
         this._currentUi = null;
         this._module = null;
      }
      
      public function loadUi(name:String, instanceName:String=null, params:*=null, strata:uint=1, cacheName:String=null, replace:Boolean=false) : Object {
         var tmp:Array = null;
         var rootCtr:UiRootContainer = null;
         var mod:UiModule = this._module;
         var uiName:String = name;
         if(!this._module.uis[name])
         {
            if(name.indexOf("::") != -1)
            {
               tmp = name.split("::");
               mod = UiModuleManager.getInstance().getModule(tmp[0]);
               if(!mod)
               {
                  throw new BeriliaError("Module [" + tmp[0] + "] does not exist");
               }
               else
               {
                  if((mod.trusted) && (!this._module.trusted))
                  {
                     throw new ApiError("You cannot load trusted UI");
                  }
                  else
                  {
                     uiName = tmp[1];
                  }
               }
            }
            else
            {
               throw new BeriliaError(name + " not found in module " + this._module.name);
            }
         }
         if(!instanceName)
         {
            instanceName = uiName;
         }
         if(mod.uis[uiName])
         {
            rootCtr = Berilia.getInstance().loadUi(mod,mod.uis[uiName],instanceName,params,replace,strata,false,cacheName);
            if((!(uiName == "tips")) && (!(uiName == "buffUi")))
            {
               FocusHandler.getInstance().setFocus(rootCtr);
            }
            return SecureCenter.secure(rootCtr,mod.trusted);
         }
         return null;
      }
      
      public function loadUiInside(name:String, container:GraphicContainer, instanceName:String=null, params:*=null) : Object {
         var tmp:Array = null;
         var newContainer:UiRootContainer = null;
         var mod:UiModule = this._module;
         var uiName:String = name;
         if(!this._module.uis[name])
         {
            if(name.indexOf("::") != -1)
            {
               tmp = name.split("::");
               mod = UiModuleManager.getInstance().getModule(tmp[0]);
               if(!mod)
               {
                  throw new BeriliaError("Module [" + tmp[0] + "] does not exist");
               }
               else
               {
                  if((mod.trusted) && (!this._module.trusted))
                  {
                     throw new ApiError("You cannot load trusted UI");
                  }
                  else
                  {
                     uiName = tmp[1];
                  }
               }
            }
            else
            {
               throw new BeriliaError(name + " not found in module " + this._module.name);
            }
         }
         if(!instanceName)
         {
            instanceName = uiName;
         }
         if(mod.uis[uiName])
         {
            newContainer = new UiRootContainer(StageShareManager.stage,mod.uis[uiName]);
            newContainer.uiModule = mod;
            newContainer.strata = container.getUi().strata;
            newContainer.depth = container.getUi().depth + 1;
            Berilia.getInstance().loadUiInside(mod.uis[uiName],instanceName,newContainer,params,false);
            container.addChild(newContainer);
            return SecureCenter.secure(newContainer,mod.trusted);
         }
         return null;
      }
      
      public function unloadUi(instanceName:String=null) : void {
         Berilia.getInstance().unloadUi(instanceName);
      }
      
      public function getUi(instanceName:String) : * {
         var sui:UiRootContainer = Berilia.getInstance().getUi(instanceName);
         if(!sui)
         {
            return null;
         }
         if((!(sui.uiModule == this._module)) && (!this._module.trusted))
         {
            throw new ArgumentError("Cannot get access to an UI owned by another module.");
         }
         else
         {
            return SecureCenter.secure(sui,this._module.trusted);
         }
      }
      
      public function getUiInstances() : Vector.<UiRootContainer> {
         var ui:UiRootContainer = null;
         var uiList:Dictionary = Berilia.getInstance().uiList;
         var res:Vector.<UiRootContainer> = new Vector.<UiRootContainer>();
         for each (ui in uiList)
         {
            if(ui.uiModule == this._module)
            {
               res.push(ui);
            }
         }
         return res;
      }
      
      public function getModuleList() : Array {
         var m:UiModule = null;
         var dml:Array = null;
         var l:Array = [];
         var ml:Array = UiModuleManager.getInstance().getModules();
         for each (m in ml)
         {
            l.push(m);
         }
         dml = UiModuleManager.getInstance().disabledModules;
         for each (m in dml)
         {
            l.push(m);
         }
         l.sortOn(["trusted","name"],[Array.NUMERIC | Array.DESCENDING,0]);
         return l;
      }
      
      public function getModule(moduleName:String, includeUnInitialized:Boolean=false) : UiModule {
         return UiModuleManager.getInstance().getModule(moduleName,includeUnInitialized);
      }
      
      public function setModuleEnable(id:String, b:Boolean) : void {
         var mods:Array = null;
         var mod:UiModule = null;
         if(b)
         {
            mods = UiModuleManager.getInstance().disabledModules;
         }
         else
         {
            mods = UiModuleManager.getInstance().getModules();
         }
         var moduleFound:Boolean = false;
         for each (mod in mods)
         {
            if((mod.id == id) && (mod.enable == !b))
            {
               mod.enable = b;
               moduleFound = true;
               break;
            }
         }
         if(!moduleFound)
         {
            StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_MOD,id,b);
         }
      }
      
      public function addChild(target:Object, child:Object) : void {
         SecureCenter.unsecure(target).addChild(SecureCenter.unsecure(child));
      }
      
      public function me() : * {
         return SecureCenter.secure(this._currentUi,this._module.trusted);
      }
      
      public function initDefaultBinds() : void {
         BindsManager.getInstance();
      }
      
      public function addShortcutHook(shortcutName:String, hook:Function, lowPriority:Boolean=false) : void {
         var targetedShortcut:Shortcut = Shortcut.getShortcutByName(shortcutName);
         if((!targetedShortcut) && (!(shortcutName == "ALL")))
         {
            throw new ApiError("Shortcut [" + shortcutName + "] does not exist");
         }
         else
         {
            priority = this._currentUi?this._currentUi.depth:0;
            if(lowPriority)
            {
               priority = 1;
            }
            listener = new GenericListener(shortcutName,this._currentUi?this._currentUi.name:"__module_" + this._module.id,hook,priority,this._currentUi?GenericListener.LISTENER_TYPE_UI:GenericListener.LISTENER_TYPE_MODULE,this._currentUi?new WeakReference(this._currentUi):null);
            BindsManager.getInstance().registerEvent(listener);
            return;
         }
      }
      
      public function addComponentHook(target:GraphicContainer, hookName:String) : void {
         var ie:InstanceEvent = null;
         var eventMsg:String = this.getEventClassName(hookName);
         if(!eventMsg)
         {
            throw new ApiError("Hook [" + hookName + "] does not exist");
         }
         else
         {
            if(!UIEventManager.getInstance().instances[target])
            {
               ie = new InstanceEvent(target,this._currentUi.uiClass);
               UIEventManager.getInstance().registerInstance(ie);
            }
            else
            {
               ie = UIEventManager.getInstance().instances[target];
            }
            ie.events[eventMsg] = eventMsg;
            return;
         }
      }
      
      public function bindApi(targetTexture:Texture, propertyName:String, value:*) : Boolean {
         var internalContent:DisplayObject = ComponentInternalAccessor.access(targetTexture,"_child");
         if(!internalContent)
         {
            return false;
         }
         try
         {
            internalContent[propertyName] = value;
         }
         catch(e:Error)
         {
            return false;
         }
         return true;
      }
      
      public function createComponent(type:String, ... params) : GraphicContainer {
         return CallWithParameters.callConstructor(getDefinitionByName("com.ankamagames.berilia.components::" + type) as Class,params);
      }
      
      public function createContainer(type:String, ... params) : * {
         return CallWithParameters.callConstructor(getDefinitionByName("com.ankamagames.berilia.types.graphic::" + type) as Class,params);
      }
      
      public function createInstanceEvent(target:DisplayObject, instance:*) : InstanceEvent {
         return new InstanceEvent(target,instance);
      }
      
      public function getEventClassName(event:String) : String {
         switch(event)
         {
            case EventEnums.EVENT_ONPRESS:
               return EventEnums.EVENT_ONPRESS_MSG;
            case EventEnums.EVENT_ONRELEASE:
               return EventEnums.EVENT_ONRELEASE_MSG;
            case EventEnums.EVENT_ONROLLOUT:
               return EventEnums.EVENT_ONROLLOUT_MSG;
            case EventEnums.EVENT_ONROLLOVER:
               return EventEnums.EVENT_ONROLLOVER_MSG;
            case EventEnums.EVENT_ONRELEASEOUTSIDE:
               return EventEnums.EVENT_ONRELEASEOUTSIDE_MSG;
            case EventEnums.EVENT_ONDOUBLECLICK:
               return EventEnums.EVENT_ONDOUBLECLICK_MSG;
            case EventEnums.EVENT_ONRIGHTCLICK:
               return EventEnums.EVENT_ONRIGHTCLICK_MSG;
            case EventEnums.EVENT_ONTEXTCLICK:
               return EventEnums.EVENT_ONTEXTCLICK_MSG;
            case EventEnums.EVENT_ONCOLORCHANGE:
               return EventEnums.EVENT_ONCOLORCHANGE_MSG;
            case EventEnums.EVENT_ONENTITYREADY:
               return EventEnums.EVENT_ONENTITYREADY_MSG;
            case EventEnums.EVENT_ONSELECTITEM:
               return EventEnums.EVENT_ONSELECTITEM_MSG;
            case EventEnums.EVENT_ONSELECTEMPTYITEM:
               return EventEnums.EVENT_ONSELECTEMPTYITEM_MSG;
            case EventEnums.EVENT_ONCREATETAB:
               return EventEnums.EVENT_ONCREATETAB_MSG;
            case EventEnums.EVENT_ONDELETETAB:
               return EventEnums.EVENT_ONDELETETAB_MSG;
            case EventEnums.EVENT_ONRENAMETAB:
               return EventEnums.EVENT_ONRENAMETAB_MSG;
            case EventEnums.EVENT_ONITEMROLLOUT:
               return EventEnums.EVENT_ONITEMROLLOUT_MSG;
            case EventEnums.EVENT_ONITEMROLLOVER:
               return EventEnums.EVENT_ONITEMROLLOVER_MSG;
            case EventEnums.EVENT_ONITEMRIGHTCLICK:
               return EventEnums.EVENT_ONITEMRIGHTCLICK_MSG;
            case EventEnums.EVENT_ONDROP:
               return EventEnums.EVENT_ONDROP_MSG;
            case EventEnums.EVENT_ONTEXTUREREADY:
               return EventEnums.EVENT_ONTEXTUREREADY_MSG;
            case EventEnums.EVENT_ONTEXTURELOADFAIL:
               return EventEnums.EVENT_ONTEXTURELOADFAIL_MSG;
            case EventEnums.EVENT_ONMAPELEMENTROLLOUT:
               return EventEnums.EVENT_ONMAPELEMENTROLLOUT_MSG;
            case EventEnums.EVENT_ONMAPELEMENTROLLOVER:
               return EventEnums.EVENT_ONMAPELEMENTROLLOVER_MSG;
            case EventEnums.EVENT_ONMAPELEMENTRIGHTCLICK:
               return EventEnums.EVENT_ONMAPELEMENTRIGHTCLICK_MSG;
            case EventEnums.EVENT_ONMAPMOVE:
               return EventEnums.EVENT_ONMAPMOVE_MSG;
            case EventEnums.EVENT_ONMAPROLLOVER:
               return EventEnums.EVENT_ONMAPROLLOVER_MSG;
            case EventEnums.EVENT_ONVIDEOCONNECTFAILED:
               return EventEnums.EVENT_ONVIDEOCONNECTFAILED_MSG;
            case EventEnums.EVENT_ONVIDEOCONNECTSUCCESS:
               return EventEnums.EVENT_ONVIDEOCONNECTSUCCESS_MSG;
            case EventEnums.EVENT_ONVIDEOBUFFERCHANGE:
               return EventEnums.EVENT_ONVIDEOBUFFERCHANGE_MSG;
            case EventEnums.EVENT_ONCOMPONENTREADY:
               return EventEnums.EVENT_ONCOMPONENTREADY_MSG;
            case EventEnums.EVENT_ONWHEEL:
               return EventEnums.EVENT_ONWHEEL_MSG;
            case EventEnums.EVENT_ONMOUSEUP:
               return EventEnums.EVENT_ONMOUSEUP_MSG;
            case EventEnums.EVENT_ONCHANGE:
               return EventEnums.EVENT_ONCHANGE_MSG;
            case EventEnums.EVENT_ONBROWSER_SESSION_TIMEOUT:
               return EventEnums.EVENT_ONBROWSER_SESSION_TIMEOUT_MSG;
            case EventEnums.EVENT_ONBROWSER_DOM_READY:
               return EventEnums.EVENT_ONBROWSER_DOM_READY_MSG;
            case EventEnums.EVENT_MIDDLECLICK:
               return EventEnums.EVENT_MIDDLECLICK_MSG;
         }
      }
      
      public function addInstanceEvent(event:InstanceEvent) : void {
         UIEventManager.getInstance().registerInstance(event);
      }
      
      public function createUri(uri:String) : Uri {
         if(((uri) && (uri.indexOf(":") == -1)) && (!(uri.indexOf("./") == 0)) && (!(uri.indexOf("\\\\") == 0)))
         {
            uri = "mod://" + this._module.id + "/" + uri;
         }
         return new Uri(uri);
      }
      
      public function showTooltip(data:*, target:*, autoHide:Boolean=false, name:String="standard", point:uint=0, relativePoint:uint=2, offset:int=3, tooltipMaker:String=null, script:Class=null, makerParam:Object=null, cacheName:String=null, mouseEnabled:Boolean=false, strata:int=4, zoom:Number=1) : void {
         var tt:Tooltip = null;
         if(this._currentUi)
         {
            tt = TooltipManager.show(data,target,this._module,autoHide,name,point,relativePoint,offset,true,tooltipMaker,script,makerParam,cacheName,mouseEnabled,strata,zoom);
            if(tt)
            {
               tt.uiModuleName = this._currentUi.name;
            }
         }
      }
      
      public function hideTooltip(name:String=null) : void {
         TooltipManager.hide(name);
      }
      
      public function textTooltipInfo(content:String, css:String=null, cssClass:String=null, maxWidth:int=400) : Object {
         return new TextTooltipInfo(content,css,cssClass,maxWidth);
      }
      
      public function getRadioGroupSelectedItem(rgName:String, me:UiRootContainer) : IRadioItem {
         var rg:RadioGroup = me.getRadioGroup(rgName);
         return rg.selectedItem;
      }
      
      public function setRadioGroupSelectedItem(rgName:String, item:IRadioItem, me:UiRootContainer) : void {
         var rg:RadioGroup = me.getRadioGroup(rgName);
         rg.selectedItem = item;
      }
      
      public function keyIsDown(keyCode:uint) : Boolean {
         return KeyPoll.getInstance().isDown(keyCode);
      }
      
      public function keyIsUp(keyCode:uint) : Boolean {
         return KeyPoll.getInstance().isUp(keyCode);
      }
      
      public function convertToTreeData(array:*) : Vector.<TreeData> {
         return TreeData.fromArray(array);
      }
      
      public function setFollowCursorUri(uri:*, lockX:Boolean=false, lockY:Boolean=false, xOffset:int=0, yOffset:int=0, scale:Number=1) : void {
         var cd:LinkedCursorData = null;
         if(uri)
         {
            cd = new LinkedCursorData();
            cd.sprite = new Texture();
            Texture(cd.sprite).uri = uri is String?new Uri(uri):uri;
            cd.sprite.scaleX = scale;
            cd.sprite.scaleY = scale;
            Texture(cd.sprite).finalize();
            cd.lockX = lockX;
            cd.lockY = lockY;
            cd.offset = new Point(xOffset,yOffset);
            LinkedCursorSpriteManager.getInstance().addItem("customUserCursor",cd);
         }
         else
         {
            LinkedCursorSpriteManager.getInstance().removeItem("customUserCursor");
         }
      }
      
      public function getFollowCursorUri() : Object {
         return LinkedCursorSpriteManager.getInstance().getItem("customUserCursor");
      }
      
      public function endDrag() : void {
         var linkCursor:LinkedCursorData = LinkedCursorSpriteManager.getInstance().getItem("DragAndDrop");
         if((linkCursor) && (linkCursor.data is SlotDragAndDropData))
         {
            LinkedCursorSpriteManager.getInstance().removeItem("DragAndDrop");
            KernelEventsManager.getInstance().processCallback(BeriliaHookList.DropEnd,SecureCenter.secure(SlotDragAndDropData(linkCursor.data).currentHolder));
         }
      }
      
      public function preloadCss(url:String) : void {
         CssManager.getInstance().preloadCss(url);
      }
      
      public function getMouseX() : int {
         return StageShareManager.mouseX;
      }
      
      public function getMouseY() : int {
         return StageShareManager.mouseY;
      }
      
      public function getStageWidth() : int {
         return StageShareManager.startWidth;
      }
      
      public function getStageHeight() : int {
         return StageShareManager.startHeight;
      }
      
      public function getWindowWidth() : int {
         return StageShareManager.stage.stageWidth;
      }
      
      public function getWindowHeight() : int {
         return StageShareManager.stage.stageHeight;
      }
      
      public function getWindowScale() : Number {
         return StageShareManager.windowScale;
      }
      
      public function setFullScreen(enabled:Boolean, onlyMaximize:Boolean=false) : void {
         StageShareManager.setFullScreen(enabled,onlyMaximize);
      }
      
      public function useIME() : Boolean {
         return Berilia.getInstance().useIME;
      }
      
      private var oldTextureUri:String;
      
      private var oldTextureBounds:Rectangle;
      
      private function getInitBounds(pTx:Texture) : Rectangle {
         var bg:MovieClip = null;
         if((this.oldTextureUri == null) || ((pTx) && (pTx.uri)) && (!(this.oldTextureUri == pTx.uri.toString())))
         {
            if(!(pTx.child is DisplayObjectContainer))
            {
               return null;
            }
            bg = (pTx.child as DisplayObjectContainer).getChildByName("bg") as MovieClip;
            if(bg)
            {
               this.oldTextureBounds.width = bg.width;
               this.oldTextureBounds.height = bg.height;
               this.oldTextureUri = pTx.uri.toString();
            }
         }
         return this.oldTextureBounds;
      }
      
      public function buildOrnamentTooltipFrom(pTexture:Texture, pTarget:Rectangle) : void {
         var bgBounds:Rectangle = null;
         var scaleX:* = NaN;
         var scaleY:* = NaN;
         var tmpPos:Rectangle = this.getInitBounds(pTexture);
         if(!tmpPos)
         {
            tmpPos = new Rectangle();
         }
         var source:DisplayObjectContainer = pTexture.child as DisplayObjectContainer;
         var bg:MovieClip = this.addPart("bg",source,pTarget,tmpPos.x,tmpPos.y) as MovieClip;
         if(bg)
         {
            bgBounds = bg.getBounds(bg);
            scaleX = (pTarget.width - bgBounds.left + (bgBounds.right - 160)) / bgBounds.width;
            scaleY = (pTarget.height - bgBounds.top + (bgBounds.bottom - 40)) / bgBounds.height;
            bg.x = bg.x + (-bgBounds.left * scaleX + bgBounds.left);
            bg.y = bg.y + (-bgBounds.top * scaleY + bgBounds.top);
            bg.scale9Grid = new Rectangle(80,20,1,1);
            bg.width = tmpPos.width * scaleX;
            bg.height = tmpPos.height * scaleY;
         }
         this.addPart("top",source,pTarget,pTarget.width / 2,0);
         this.addPart("picto",source,pTarget,pTarget.width / 2,0);
         this.addPart("right",source,pTarget,pTarget.width,pTarget.height / 2);
         this.addPart("bottom",source,pTarget,pTarget.width / 2,pTarget.height - 1);
         this.addPart("left",source,pTarget,0,pTarget.height / 2);
      }
      
      private function addPart(name:String, source:DisplayObjectContainer, target:Rectangle, x:int, y:int) : DisplayObject {
         if(!source)
         {
            return null;
         }
         var part:DisplayObject = source.getChildByName(name);
         if(part != null)
         {
            part.x = target.x + x;
            part.y = target.y + y;
         }
         return part;
      }
      
      public function getTextSize(pText:String, pCss:Uri, pCssClass:String) : Rectangle {
         if(!_label)
         {
            _label = this.createComponent("Label") as Label;
         }
         _label.css = pCss;
         _label.cssClass = pCssClass;
         _label.fixedWidth = false;
         _label.text = pText;
         return new Rectangle(0,0,_label.textWidth,_label.textHeight);
      }
      
      public function replaceParams(text:String, params:Array, replace:String="%") : String {
         return I18n.replaceParams(text,params,replace);
      }
      
      public function replaceKey(text:String) : String {
         return LangManager.getInstance().replaceKey(text,true);
      }
      
      public function getText(key:String, ... params) : String {
         return I18n.getUiText(key,params);
      }
      
      public function getTextFromKey(key:uint, replace:String="%", ... params) : String {
         return I18n.getText(key,params,replace);
      }
      
      public function processText(str:String, gender:String, singular:Boolean=true) : String {
         return PatternDecoder.combine(str,gender,singular);
      }
      
      public function decodeText(str:String, params:Array) : String {
         return PatternDecoder.decode(str,params);
      }
   }
}
