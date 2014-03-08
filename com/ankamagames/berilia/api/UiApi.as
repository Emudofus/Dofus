package com.ankamagames.berilia.api
{
   import com.ankamagames.berilia.interfaces.IApi;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Logger;
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
   import __AS3__.vec.Vector;
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
      
      private var _module:UiModule;
      
      private var _currentUi:UiRootContainer;
      
      public function set module(param1:UiModule) : void {
         if(!this._module)
         {
            this._module = param1;
         }
      }
      
      public function set currentUi(param1:UiRootContainer) : void {
         if(!this._currentUi)
         {
            this._currentUi = param1;
         }
      }
      
      public function destroy() : void {
         this._currentUi = null;
         this._module = null;
      }
      
      public function loadUi(param1:String, param2:String=null, param3:*=null, param4:uint=1, param5:String=null, param6:Boolean=false) : Object {
         var _loc9_:Array = null;
         var _loc10_:UiRootContainer = null;
         var _loc7_:UiModule = this._module;
         var _loc8_:String = param1;
         if(!this._module.uis[param1])
         {
            if(param1.indexOf("::") != -1)
            {
               _loc9_ = param1.split("::");
               _loc7_ = UiModuleManager.getInstance().getModule(_loc9_[0]);
               if(!_loc7_)
               {
                  throw new BeriliaError("Module [" + _loc9_[0] + "] does not exist");
               }
               else
               {
                  if((_loc7_.trusted) && !this._module.trusted)
                  {
                     throw new ApiError("You cannot load trusted UI");
                  }
                  else
                  {
                     _loc8_ = _loc9_[1];
                  }
               }
            }
            else
            {
               throw new BeriliaError(param1 + " not found in module " + this._module.name);
            }
         }
         if(!param2)
         {
            param2 = _loc8_;
         }
         if(_loc7_.uis[_loc8_])
         {
            _loc10_ = Berilia.getInstance().loadUi(_loc7_,_loc7_.uis[_loc8_],param2,param3,param6,param4,false,param5);
            if(!(_loc8_ == "tips") && !(_loc8_ == "buffUi"))
            {
               FocusHandler.getInstance().setFocus(_loc10_);
            }
            return SecureCenter.secure(_loc10_,_loc7_.trusted);
         }
         return null;
      }
      
      public function loadUiInside(param1:String, param2:GraphicContainer, param3:String=null, param4:*=null) : Object {
         var _loc7_:Array = null;
         var _loc8_:UiRootContainer = null;
         var _loc5_:UiModule = this._module;
         var _loc6_:String = param1;
         if(!this._module.uis[param1])
         {
            if(param1.indexOf("::") != -1)
            {
               _loc7_ = param1.split("::");
               _loc5_ = UiModuleManager.getInstance().getModule(_loc7_[0]);
               if(!_loc5_)
               {
                  throw new BeriliaError("Module [" + _loc7_[0] + "] does not exist");
               }
               else
               {
                  if((_loc5_.trusted) && !this._module.trusted)
                  {
                     throw new ApiError("You cannot load trusted UI");
                  }
                  else
                  {
                     _loc6_ = _loc7_[1];
                  }
               }
            }
            else
            {
               throw new BeriliaError(param1 + " not found in module " + this._module.name);
            }
         }
         if(!param3)
         {
            param3 = _loc6_;
         }
         if(_loc5_.uis[_loc6_])
         {
            _loc8_ = new UiRootContainer(StageShareManager.stage,_loc5_.uis[_loc6_]);
            _loc8_.uiModule = _loc5_;
            _loc8_.strata = param2.getUi().strata;
            _loc8_.depth = param2.getUi().depth + 1;
            Berilia.getInstance().loadUiInside(_loc5_.uis[_loc6_],param3,_loc8_,param4,false);
            param2.addChild(_loc8_);
            return SecureCenter.secure(_loc8_,_loc5_.trusted);
         }
         return null;
      }
      
      public function unloadUi(param1:String=null) : void {
         Berilia.getInstance().unloadUi(param1);
      }
      
      public function getUi(param1:String) : * {
         var _loc2_:UiRootContainer = Berilia.getInstance().getUi(param1);
         if(!_loc2_)
         {
            return null;
         }
         if(!(_loc2_.uiModule == this._module) && !this._module.trusted)
         {
            throw new ArgumentError("Cannot get access to an UI owned by another module.");
         }
         else
         {
            return SecureCenter.secure(_loc2_,this._module.trusted);
         }
      }
      
      public function getUiInstances() : Vector.<UiRootContainer> {
         var _loc3_:UiRootContainer = null;
         var _loc1_:Dictionary = Berilia.getInstance().uiList;
         var _loc2_:Vector.<UiRootContainer> = new Vector.<UiRootContainer>();
         for each (_loc3_ in _loc1_)
         {
            if(_loc3_.uiModule == this._module)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getModuleList() : Array {
         var _loc3_:UiModule = null;
         var _loc4_:Array = null;
         var _loc1_:Array = [];
         var _loc2_:Array = UiModuleManager.getInstance().getModules();
         for each (_loc3_ in _loc2_)
         {
            _loc1_.push(_loc3_);
         }
         _loc4_ = UiModuleManager.getInstance().disabledModule;
         for each (_loc3_ in _loc4_)
         {
            _loc1_.push(_loc3_);
         }
         _loc1_.sortOn(["trusted","name"],[Array.NUMERIC | Array.DESCENDING,0]);
         return _loc1_;
      }
      
      public function setModuleEnable(param1:String, param2:Boolean) : void {
         var _loc3_:Array = null;
         var _loc4_:UiModule = null;
         if(param2)
         {
            _loc3_ = UiModuleManager.getInstance().disabledModule;
         }
         else
         {
            _loc3_ = UiModuleManager.getInstance().getModules();
         }
         for each (_loc4_ in _loc3_)
         {
            if(_loc4_.id == param1 && _loc4_.enable == !param2)
            {
               _loc4_.enable = param2;
            }
         }
      }
      
      public function addChild(param1:Object, param2:Object) : void {
         SecureCenter.unsecure(param1).addChild(SecureCenter.unsecure(param2));
      }
      
      public function me() : * {
         return SecureCenter.secure(this._currentUi,this._module.trusted);
      }
      
      public function initDefaultBinds() : void {
         BindsManager.getInstance();
      }
      
      public function addShortcutHook(param1:String, param2:Function, param3:Boolean=false) : void {
         var _loc4_:Shortcut = Shortcut.getShortcutByName(param1);
         if(!_loc4_ && !(param1 == "ALL"))
         {
            throw new ApiError("Shortcut [" + param1 + "] does not exist");
         }
         else
         {
            _loc5_ = this._currentUi?this._currentUi.depth:0;
            if(param3)
            {
               _loc5_ = 1;
            }
            _loc6_ = new GenericListener(param1,this._currentUi?this._currentUi.name:"__module_" + this._module.id,param2,_loc5_,this._currentUi?GenericListener.LISTENER_TYPE_UI:GenericListener.LISTENER_TYPE_MODULE,this._currentUi?new WeakReference(this._currentUi):null);
            BindsManager.getInstance().registerEvent(_loc6_);
            return;
         }
      }
      
      public function addComponentHook(param1:GraphicContainer, param2:String) : void {
         var _loc4_:InstanceEvent = null;
         var _loc3_:String = this.getEventClassName(param2);
         if(!_loc3_)
         {
            throw new ApiError("Hook [" + param2 + "] does not exist");
         }
         else
         {
            if(!UIEventManager.getInstance().instances[param1])
            {
               _loc4_ = new InstanceEvent(param1,this._currentUi.uiClass);
               UIEventManager.getInstance().registerInstance(_loc4_);
            }
            else
            {
               _loc4_ = UIEventManager.getInstance().instances[param1];
            }
            _loc4_.events[_loc3_] = _loc3_;
            return;
         }
      }
      
      public function bindApi(param1:Texture, param2:String, param3:*) : Boolean {
         var targetTexture:Texture = param1;
         var propertyName:String = param2;
         var value:* = param3;
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
      
      public function createComponent(param1:String, ... rest) : GraphicContainer {
         return CallWithParameters.callConstructor(getDefinitionByName("com.ankamagames.berilia.components::" + param1) as Class,rest);
      }
      
      public function createContainer(param1:String, ... rest) : * {
         return CallWithParameters.callConstructor(getDefinitionByName("com.ankamagames.berilia.types.graphic::" + param1) as Class,rest);
      }
      
      public function createInstanceEvent(param1:DisplayObject, param2:*) : InstanceEvent {
         return new InstanceEvent(param1,param2);
      }
      
      public function getEventClassName(param1:String) : String {
         switch(param1)
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
            default:
               return null;
         }
      }
      
      public function addInstanceEvent(param1:InstanceEvent) : void {
         UIEventManager.getInstance().registerInstance(param1);
      }
      
      public function createUri(param1:String) : Uri {
         if(((param1) && (param1.indexOf(":") == -1)) && (!(param1.indexOf("./") == 0)) && !(param1.indexOf("\\\\") == 0))
         {
            param1 = "mod://" + this._module.id + "/" + param1;
         }
         return new Uri(param1);
      }
      
      public function showTooltip(param1:*, param2:*, param3:Boolean=false, param4:String="standard", param5:uint=0, param6:uint=2, param7:int=3, param8:String=null, param9:Class=null, param10:Object=null, param11:String=null, param12:Boolean=false, param13:int=4, param14:Number=1) : void {
         var _loc15_:Tooltip = null;
         if(this._currentUi)
         {
            _loc15_ = TooltipManager.show(param1,param2,this._module,param3,param4,param5,param6,param7,true,param8,param9,param10,param11,param12,param13,param14);
            if(_loc15_)
            {
               _loc15_.uiModuleName = this._currentUi.name;
            }
         }
      }
      
      public function hideTooltip(param1:String=null) : void {
         TooltipManager.hide(param1);
      }
      
      public function textTooltipInfo(param1:String, param2:String=null, param3:String=null, param4:int=400) : Object {
         return new TextTooltipInfo(param1,param2,param3,param4);
      }
      
      public function getRadioGroupSelectedItem(param1:String, param2:UiRootContainer) : IRadioItem {
         var _loc3_:RadioGroup = param2.getRadioGroup(param1);
         return _loc3_.selectedItem;
      }
      
      public function setRadioGroupSelectedItem(param1:String, param2:IRadioItem, param3:UiRootContainer) : void {
         var _loc4_:RadioGroup = param3.getRadioGroup(param1);
         _loc4_.selectedItem = param2;
      }
      
      public function keyIsDown(param1:uint) : Boolean {
         return KeyPoll.getInstance().isDown(param1);
      }
      
      public function keyIsUp(param1:uint) : Boolean {
         return KeyPoll.getInstance().isUp(param1);
      }
      
      public function convertToTreeData(param1:*) : Vector.<TreeData> {
         return TreeData.fromArray(param1);
      }
      
      public function setFollowCursorUri(param1:*, param2:Boolean=false, param3:Boolean=false, param4:int=0, param5:int=0, param6:Number=1) : void {
         var _loc7_:LinkedCursorData = null;
         if(param1)
         {
            _loc7_ = new LinkedCursorData();
            _loc7_.sprite = new Texture();
            Texture(_loc7_.sprite).uri = param1 is String?new Uri(param1):param1;
            _loc7_.sprite.scaleX = param6;
            _loc7_.sprite.scaleY = param6;
            Texture(_loc7_.sprite).finalize();
            _loc7_.lockX = param2;
            _loc7_.lockY = param3;
            _loc7_.offset = new Point(param4,param5);
            LinkedCursorSpriteManager.getInstance().addItem("customUserCursor",_loc7_);
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
         var _loc1_:LinkedCursorData = LinkedCursorSpriteManager.getInstance().getItem("DragAndDrop");
         if((_loc1_) && _loc1_.data is SlotDragAndDropData)
         {
            LinkedCursorSpriteManager.getInstance().removeItem("DragAndDrop");
            KernelEventsManager.getInstance().processCallback(BeriliaHookList.DropEnd,SecureCenter.secure(SlotDragAndDropData(_loc1_.data).currentHolder));
         }
      }
      
      public function preloadCss(param1:String) : void {
         CssManager.getInstance().preloadCss(param1);
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
      
      public function setFullScreen(param1:Boolean, param2:Boolean=false) : void {
         StageShareManager.setFullScreen(param1,param2);
      }
      
      public function useIME() : Boolean {
         return Berilia.getInstance().useIME;
      }
      
      private var oldTextureUri:String;
      
      private var oldTextureBounds:Rectangle;
      
      private function getInitBounds(param1:Texture) : Rectangle {
         var _loc2_:MovieClip = null;
         if(this.oldTextureUri == null || ((param1) && (param1.uri)) && (!(this.oldTextureUri == param1.uri.toString())))
         {
            if(!(param1.child is DisplayObjectContainer))
            {
               return null;
            }
            _loc2_ = (param1.child as DisplayObjectContainer).getChildByName("bg") as MovieClip;
            if(_loc2_)
            {
               this.oldTextureBounds.width = _loc2_.width;
               this.oldTextureBounds.height = _loc2_.height;
               this.oldTextureUri = param1.uri.toString();
            }
         }
         return this.oldTextureBounds;
      }
      
      public function buildOrnamentTooltipFrom(param1:Texture, param2:Rectangle) : void {
         var _loc6_:Rectangle = null;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc3_:Rectangle = this.getInitBounds(param1);
         if(!_loc3_)
         {
            _loc3_ = new Rectangle();
         }
         var _loc4_:DisplayObjectContainer = param1.child as DisplayObjectContainer;
         var _loc5_:MovieClip = this.addPart("bg",_loc4_,param2,_loc3_.x,_loc3_.y) as MovieClip;
         if(_loc5_)
         {
            _loc6_ = _loc5_.getBounds(_loc5_);
            _loc7_ = (param2.width - _loc6_.left + (_loc6_.right - 160)) / _loc6_.width;
            _loc8_ = (param2.height - _loc6_.top + (_loc6_.bottom - 40)) / _loc6_.height;
            _loc5_.x = _loc5_.x + (-_loc6_.left * _loc7_ + _loc6_.left);
            _loc5_.y = _loc5_.y + (-_loc6_.top * _loc8_ + _loc6_.top);
            _loc5_.scale9Grid = new Rectangle(80,20,1,1);
            _loc5_.width = _loc3_.width * _loc7_;
            _loc5_.height = _loc3_.height * _loc8_;
         }
         this.addPart("top",_loc4_,param2,param2.width / 2,0);
         this.addPart("picto",_loc4_,param2,param2.width / 2,0);
         this.addPart("right",_loc4_,param2,param2.width,param2.height / 2);
         this.addPart("bottom",_loc4_,param2,param2.width / 2,param2.height-1);
         this.addPart("left",_loc4_,param2,0,param2.height / 2);
      }
      
      private function addPart(param1:String, param2:DisplayObjectContainer, param3:Rectangle, param4:int, param5:int) : DisplayObject {
         if(!param2)
         {
            return null;
         }
         var _loc6_:DisplayObject = param2.getChildByName(param1);
         if(_loc6_ != null)
         {
            _loc6_.x = param3.x + param4;
            _loc6_.y = param3.y + param5;
         }
         return _loc6_;
      }
      
      public function replaceParams(param1:String, param2:Array, param3:String="%") : String {
         return I18n.replaceParams(param1,param2,param3);
      }
      
      public function replaceKey(param1:String) : String {
         return LangManager.getInstance().replaceKey(param1,true);
      }
      
      public function getText(param1:String, ... rest) : String {
         return I18n.getUiText(param1,rest);
      }
      
      public function getTextFromKey(param1:uint, param2:String="%", ... rest) : String {
         return I18n.getText(param1,rest,param2);
      }
      
      public function processText(param1:String, param2:String, param3:Boolean=true) : String {
         return PatternDecoder.combine(param1,param2,param3);
      }
      
      public function decodeText(param1:String, param2:Array) : String {
         return PatternDecoder.decode(param1,param2);
      }
   }
}
