package com.ankamagames.dofus.internalDatacenter.items
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.inventory.preset.PresetItem;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   
   public class PresetWrapper extends ItemWrapper implements IDataCenter
   {
      
      public function PresetWrapper() {
         super();
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(PresetWrapper));
      
      public static function create(param1:int, param2:int, param3:Vector.<PresetItem>, param4:Boolean=false) : PresetWrapper {
         var _loc7_:Uri = null;
         var _loc9_:* = false;
         var _loc10_:PresetItem = null;
         var _loc11_:MountWrapper = null;
         var _loc5_:PresetWrapper = new PresetWrapper();
         _loc5_.id = param1;
         _loc5_.gfxId = param2;
         _loc5_.objects = new Array(16);
         _loc5_.mount = param4;
         var _loc6_:Uri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "bitmap/failureSlot.png");
         var _loc8_:* = 0;
         while(_loc8_ < 16)
         {
            _loc9_ = false;
            for each (_loc10_ in param3)
            {
               if(_loc10_.position == _loc8_)
               {
                  if(_loc10_.objUid)
                  {
                     _loc5_.objects[_loc8_] = InventoryManager.getInstance().inventory.getItem(_loc10_.objUid);
                     _loc5_.objects[_loc8_].backGroundIconUri = null;
                  }
                  else
                  {
                     _loc5_.objects[_loc8_] = ItemWrapper.create(0,0,_loc10_.objGid,1,null,false);
                     _loc5_.objects[_loc8_].backGroundIconUri = _loc6_;
                     _loc5_.objects[_loc8_].active = false;
                  }
                  _loc9_ = true;
               }
            }
            if(_loc8_ == 8 && !_loc9_ && (param4))
            {
               _loc11_ = MountWrapper.create();
               _loc5_.objects[_loc8_] = _loc11_;
               _loc5_.objects[_loc8_].backGroundIconUri = null;
               _loc9_ = true;
            }
            if(!_loc9_)
            {
               switch(_loc8_)
               {
                  case 9:
                  case 10:
                  case 11:
                  case 12:
                  case 13:
                  case 14:
                     _loc7_ = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_slotDofus");
                     break;
                  default:
                     _loc7_ = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_slotItem" + _loc8_);
               }
               _loc5_.objects[_loc8_] = SimpleTextureWrapper.create(_loc7_);
            }
            _loc8_++;
         }
         return _loc5_;
      }
      
      public var gfxId:int;
      
      public var _objects:Array;
      
      public var mount:Boolean;
      
      private var _uri:Uri;
      
      private var _pngMode:Boolean;
      
      public function get objects() : Array {
         var _loc1_:MountWrapper = null;
         if(this.mount)
         {
            if((PlayedCharacterManager.getInstance().mount) || (!PlayedCharacterManager.getInstance().mount) && (this._objects[8]))
            {
               if(!(this._objects[8] is MountWrapper))
               {
                  _loc1_ = MountWrapper.create();
                  this._objects[8] = _loc1_;
                  this._objects[8].backGroundIconUri = null;
               }
               else
               {
                  this._objects[8].update(0,0,0,0,null);
               }
            }
         }
         return this._objects;
      }
      
      public function set objects(param1:Array) : void {
         this._objects = param1;
      }
      
      override public function get iconUri() : Uri {
         return this.getIconUri();
      }
      
      override public function get fullSizeIconUri() : Uri {
         return this.getIconUri();
      }
      
      override public function get errorIconUri() : Uri {
         return null;
      }
      
      public function get uri() : Uri {
         return this._uri;
      }
      
      override public function getIconUri(param1:Boolean=true) : Uri {
         if(!this._uri)
         {
            this._pngMode = false;
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path").concat("presets/icons.swf|icon_").concat(this.gfxId));
         }
         return this._uri;
      }
      
      override public function get info1() : String {
         return null;
      }
      
      override public function get timer() : int {
         return 0;
      }
      
      override public function get active() : Boolean {
         return true;
      }
      
      public function updateObject(param1:PresetItem) : void {
         var _loc3_:Uri = null;
         var _loc5_:uint = 0;
         var _loc2_:Uri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "bitmap/failureSlot.png");
         var _loc4_:int = param1.position;
         if(this._objects[_loc4_])
         {
            if(this._objects[_loc4_].objectGID == param1.objGid)
            {
               if(param1.objUid)
               {
                  this._objects[_loc4_] = InventoryManager.getInstance().inventory.getItem(param1.objUid);
                  if(this._objects[_loc4_])
                  {
                     this._objects[_loc4_].backGroundIconUri = null;
                  }
               }
               else
               {
                  _loc5_ = param1.objGid;
                  this._objects[_loc4_] = ItemWrapper.create(0,0,_loc5_,1,null,false);
                  this._objects[_loc4_].backGroundIconUri = _loc2_;
                  this._objects[_loc4_].active = false;
               }
            }
            else
            {
               if(param1.objGid == 0 && param1.objUid == 0)
               {
                  switch(_loc4_)
                  {
                     case 9:
                     case 10:
                     case 11:
                     case 12:
                     case 13:
                     case 14:
                        _loc3_ = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_slotDofus");
                        break;
                     default:
                        _loc3_ = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_slotItem" + _loc4_);
                  }
                  this._objects[_loc4_] = SimpleTextureWrapper.create(_loc3_);
               }
            }
         }
      }
      
      override public function addHolder(param1:ISlotDataHolder) : void {
      }
      
      override public function removeHolder(param1:ISlotDataHolder) : void {
      }
   }
}
