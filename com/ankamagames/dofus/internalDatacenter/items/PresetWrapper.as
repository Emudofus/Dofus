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
      
      public static function create(id:int, gfxId:int, objects:Vector.<PresetItem>, mount:Boolean=false) : PresetWrapper {
         var emptyUri:Uri = null;
         var objExists:* = false;
         var item:PresetItem = null;
         var mountFakeItemWrapper:MountWrapper = null;
         var presetWrapper:PresetWrapper = new PresetWrapper();
         presetWrapper.id = id;
         presetWrapper.gfxId = gfxId;
         presetWrapper.objects = new Array(16);
         presetWrapper.mount = mount;
         var delinkedUri:Uri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "bitmap/failureSlot.png");
         var i:int = 0;
         while(i < 16)
         {
            objExists = false;
            for each (item in objects)
            {
               if(item.position == i)
               {
                  if(item.objUid)
                  {
                     presetWrapper.objects[i] = InventoryManager.getInstance().inventory.getItem(item.objUid);
                     presetWrapper.objects[i].backGroundIconUri = null;
                  }
                  else
                  {
                     presetWrapper.objects[i] = ItemWrapper.create(0,0,item.objGid,1,null,false);
                     presetWrapper.objects[i].backGroundIconUri = delinkedUri;
                     presetWrapper.objects[i].active = false;
                  }
                  objExists = true;
               }
            }
            if((i == 8) && (!objExists) && (mount))
            {
               mountFakeItemWrapper = MountWrapper.create();
               presetWrapper.objects[i] = mountFakeItemWrapper;
               presetWrapper.objects[i].backGroundIconUri = null;
               objExists = true;
            }
            if(!objExists)
            {
               switch(i)
               {
                  case 9:
                  case 10:
                  case 11:
                  case 12:
                  case 13:
                  case 14:
                     emptyUri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_slotDofus");
                     break;
               }
               presetWrapper.objects[i] = SimpleTextureWrapper.create(emptyUri);
            }
            i++;
         }
         return presetWrapper;
      }
      
      public var gfxId:int;
      
      public var _objects:Array;
      
      public var mount:Boolean;
      
      private var _uri:Uri;
      
      private var _pngMode:Boolean;
      
      public function get objects() : Array {
         var mountFakeItemWrapper:MountWrapper = null;
         if(this.mount)
         {
            if((PlayedCharacterManager.getInstance().mount) || (!PlayedCharacterManager.getInstance().mount) && (this._objects[8]))
            {
               if(!(this._objects[8] is MountWrapper))
               {
                  mountFakeItemWrapper = MountWrapper.create();
                  this._objects[8] = mountFakeItemWrapper;
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
      
      public function set objects(a:Array) : void {
         this._objects = a;
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
      
      override public function getIconUri(pngMode:Boolean=true) : Uri {
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
      
      public function updateObject(object:PresetItem) : void {
         var emptyUri:Uri = null;
         var gid:uint = 0;
         var delinkedUri:Uri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "bitmap/failureSlot.png");
         var i:int = object.position;
         if(this._objects[i])
         {
            if(this._objects[i].objectGID == object.objGid)
            {
               if(object.objUid)
               {
                  this._objects[i] = InventoryManager.getInstance().inventory.getItem(object.objUid);
                  if(this._objects[i])
                  {
                     this._objects[i].backGroundIconUri = null;
                  }
               }
               else
               {
                  gid = object.objGid;
                  this._objects[i] = ItemWrapper.create(0,0,gid,1,null,false);
                  this._objects[i].backGroundIconUri = delinkedUri;
                  this._objects[i].active = false;
               }
            }
            else
            {
               if((object.objGid == 0) && (object.objUid == 0))
               {
                  switch(i)
                  {
                     case 9:
                     case 10:
                     case 11:
                     case 12:
                     case 13:
                     case 14:
                        emptyUri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_slotDofus");
                        break;
                  }
                  this._objects[i] = SimpleTextureWrapper.create(emptyUri);
               }
            }
         }
      }
      
      override public function addHolder(h:ISlotDataHolder) : void {
      }
      
      override public function removeHolder(h:ISlotDataHolder) : void {
      }
   }
}
