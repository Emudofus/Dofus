package com.ankamagames.dofus.internalDatacenter.guild
{
   import flash.utils.Proxy;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.datacenter.guild.EmblemSymbol;
   import com.ankamagames.dofus.datacenter.guild.EmblemBackground;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;


   public class EmblemWrapper extends Proxy implements IDataCenter, ISlotData
   {
         

      public function EmblemWrapper() {
         super();
      }

      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EmblemWrapper));

      private static var _cache:Array = new Array();

      public static const UP:uint = 1;

      public static const BACK:uint = 2;

      public static function create(pIdEmblem:uint, pType:uint, pColor:uint=0, useCache:Boolean=false) : EmblemWrapper {
         var emblem:EmblemWrapper = null;
         var path:String = null;
         var pathFullSize:String = null;
         var iconId:* = 0;
         var symbol:EmblemSymbol = null;
         var back:EmblemBackground = null;
         if((!_cache[pIdEmblem])||(!useCache))
         {
            emblem=new EmblemWrapper();
            emblem.idEmblem=pIdEmblem;
            if(useCache)
            {
               _cache[pIdEmblem]=emblem;
            }
         }
         else
         {
            emblem=_cache[pIdEmblem];
         }
         emblem._type=pType;
         switch(pType)
         {
            case UP:
               symbol=EmblemSymbol.getEmblemSymbolById(pIdEmblem);
               iconId=symbol.iconId;
               emblem.order=symbol.order;
               emblem.category=symbol.categoryId;
               path=XmlConfig.getInstance().getEntry("config.gfx.path.emblem_icons.small")+"up/";
               pathFullSize=XmlConfig.getInstance().getEntry("config.gfx.path.emblem_icons.large")+"up/";
               break;
            case BACK:
               back=EmblemBackground.getEmblemBackgroundById(pIdEmblem);
               emblem.order=back.order;
               iconId=pIdEmblem;
               path=XmlConfig.getInstance().getEntry("config.gfx.path.emblem_icons.small")+"back/";
               pathFullSize=XmlConfig.getInstance().getEntry("config.gfx.path.emblem_icons.large")+"back/";
               break;
         }
         emblem._uri=new Uri(path+iconId+".png");
         emblem._fullSizeUri=new Uri(pathFullSize+iconId+".swf");
         emblem._color=pColor;
         return emblem;
      }

      public static function getEmblemFromId(emblemId:uint) : EmblemWrapper {
         return _cache[emblemId];
      }

      private var _uri:Uri;

      private var _fullSizeUri:Uri;

      private var _color:uint;

      private var _type:uint;

      public var idEmblem:uint;

      public var order:int;

      public var category:int;

      public function get iconUri() : Uri {
         return this._uri;
      }

      public function get fullSizeIconUri() : Uri {
         return this._fullSizeUri;
      }

      public function get backGroundIconUri() : Uri {
         return new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("bitmap/emptySlot.png"));
      }

      public function set backGroundIconUri(bgUri:Uri) : void {
         
      }

      public function get info1() : String {
         return null;
      }

      public function get timer() : int {
         return 0;
      }

      public function get active() : Boolean {
         return true;
      }

      public function get type() : uint {
         return this._type;
      }

      public function get color() : uint {
         return this._color;
      }

      public function get errorIconUri() : Uri {
         return null;
      }

      public function update(pIdEmblem:uint, pType:uint, pColor:uint=0) : void {
         var path:String = null;
         var pathFullSize:String = null;
         var iconId:* = 0;
         var symbol:EmblemSymbol = null;
         var back:EmblemBackground = null;
         this.idEmblem=pIdEmblem;
         this._type=pType;
         switch(pType)
         {
            case UP:
               symbol=EmblemSymbol.getEmblemSymbolById(pIdEmblem);
               iconId=symbol.iconId;
               this.order=symbol.order;
               this.category=symbol.categoryId;
               path=XmlConfig.getInstance().getEntry("config.gfx.path.emblem_icons.small")+"up/";
               pathFullSize=XmlConfig.getInstance().getEntry("config.gfx.path.emblem_icons.large")+"up/";
               break;
            case BACK:
               back=EmblemBackground.getEmblemBackgroundById(pIdEmblem);
               this.order=back.order;
               iconId=pIdEmblem;
               path=XmlConfig.getInstance().getEntry("config.gfx.path.emblem_icons.small")+"back/";
               pathFullSize=XmlConfig.getInstance().getEntry("config.gfx.path.emblem_icons.large")+"back/";
               break;
         }
         this._uri=new Uri(path+iconId+".png");
         this._fullSizeUri=new Uri(pathFullSize+iconId+".swf");
         this._color=pColor;
      }

      public function addHolder(h:ISlotDataHolder) : void {
         
      }

      public function removeHolder(h:ISlotDataHolder) : void {
         
      }
   }

}