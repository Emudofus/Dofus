package ui
{
   import d2api.SoundApi;
   import d2api.DataApi;
   import d2components.GraphicContainer;
   import d2components.ButtonContainer;
   import d2components.Label;
   import d2components.Texture;
   import d2data.SubArea;
   import d2data.WorldMap;
   import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import d2hooks.FlagAdded;
   import ui.type.Flag;
   import d2data.MapPosition;
   import d2data.Dungeon;
   import flash.geom.Point;
   import d2actions.PlaySound;
   
   public class CartographyPopup extends AbstractCartographyUi
   {
      
      public function CartographyPopup() {
         super();
      }
      
      private static const HINTS_LAYER:String = "Hints";
      
      private static const AREAS_SHAPES_LAYER:String = "AreasShapes";
      
      private static const FLAGS_LAYER:String = "Flags";
      
      private static const DUNGEONS_LAYER:String = "Dungeons";
      
      public var soundApi:SoundApi;
      
      public var dataApi:DataApi;
      
      public var popCtr:GraphicContainer;
      
      public var btn_close:ButtonContainer;
      
      public var lbl_title:Label;
      
      public var lbl_subtitle:Label;
      
      public var tx_background:Texture;
      
      public var btn_flag:ButtonContainer;
      
      public var btn_grid:ButtonContainer;
      
      public var ctrSubAreaInfo:GraphicContainer;
      
      public var ctrSubAreaInfoBg:GraphicContainer;
      
      public var lblSubAreaInfo:Label;
      
      private var _selectedSubArea:SubArea;
      
      private var _flagUri:String;
      
      private var _iconsUri:String;
      
      private var _dungeons:Array;
      
      private var _notVisible:Vector.<int>;
      
      private var _addingFlag:Boolean;
      
      private var _currentWorldMap:WorldMap;
      
      private var _gridDisplayed:Boolean;
      
      override public function main(params:Object = null) : void {
         super.main(params);
         this.soundApi.playSound(SoundTypeEnum.POPUP_INFO);
         this.btn_close.soundId = SoundEnum.WINDOW_CLOSE;
         this.popCtr.getUi().showModalContainer = true;
         this.lbl_title.text = params.title;
         if(params.subtitle)
         {
            this.lbl_subtitle.text = params.subtitle;
         }
         this.popCtr.height = mapViewer.height + 110;
         this.popCtr.width = mapViewer.width + 50;
         this._flagUri = sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|flag0";
         this._iconsUri = uiApi.me().getConstant("icons_uri") + "/assets.swf|icon_";
         this.btn_flag.soundId = SoundEnum.CHECKBOX_CHECKED;
         this._dungeons = new Array();
         this._notVisible = new Vector.<int>();
         uiApi.addComponentHook(this.btn_flag,"onRollOver");
         uiApi.addComponentHook(this.btn_flag,"onRollOut");
         uiApi.addComponentHook(this.btn_grid,"onRollOver");
         uiApi.addComponentHook(this.btn_grid,"onRollOut");
         uiApi.addComponentHook(mapViewer,"onMapElementRollOver");
         uiApi.addComponentHook(mapViewer,"onRollOver");
         uiApi.addComponentHook(mapViewer,"onRollOut");
         uiApi.addComponentHook(mapViewer,"onRelease");
         uiApi.addComponentHook(mapViewer,"onPress");
         uiApi.addComponentHook(mapViewer,"onMapRollOver");
         sysApi.addHook(FlagAdded,this.onFlagAdded);
         sysApi.addEventListener(this.onEnterFrame,"cartographyPopup");
         this.initMap(params.selectedSubareaId,params.subareaIds);
         this._gridDisplayed = sysApi.getData("ShowMapGrid",true);
         mapViewer.showGrid = this._gridDisplayed;
         this.btn_grid.selected = this._gridDisplayed;
      }
      
      private function initMap(pSelectedSubAreaId:int, pSubAreasIds:Object) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function addFlag(pX:int, pY:int, pId:String, pUri:String = null, pScale:Number = 1, pLegend:String = null, pColor:int = -1) : void {
         mapViewer.addIcon(FLAGS_LAYER,pId,pUri,pX,pY,pScale,pLegend,true,pColor);
      }
      
      private function addSubAreaPositionFlag(pSubAreaId:int, pColor:int) : void {
         var flagUri:String = null;
         var subArea:SubArea = mapApi.getSubArea(pSubAreaId);
         if((!subArea.worldmap) || (!(subArea.worldmap.id == currentWorldId)))
         {
            return;
         }
         var pos:Object = this.getSubAreaCenter(pSubAreaId);
         if(pos)
         {
            if(!this._dungeons[pSubAreaId])
            {
               if(this._notVisible.indexOf(pSubAreaId) != -1)
               {
                  flagUri = this._flagUri;
               }
               this.addFlag(pos.x,pos.y,"flag_" + pSubAreaId,flagUri,2,subArea.area.name + " - " + subArea.name,pColor);
            }
            else
            {
               mapViewer.addIcon(DUNGEONS_LAYER,"dungeon_" + pSubAreaId,this._iconsUri + "422",pos.x,pos.y,1,subArea.name,true);
            }
         }
      }
      
      private function isDungeon(pSubAreaId:int) : int {
         var mapPos:MapPosition = null;
         var dungeon:Object = null;
         var dungeonPos:MapPosition = null;
         var dungeonIds:Object = null;
         var mapId:* = 0;
         var count:* = 0;
         var subArea:SubArea = this.dataApi.getSubArea(pSubAreaId);
         var dungeons:Object = this.dataApi.getDungeons();
         dungeonIds = this.dataApi.queryEquals(Dungeon,"mapIds",subArea.mapIds);
         if(dungeonIds.length > 0)
         {
            dungeon = this.dataApi.getDungeon(dungeonIds[0]);
            if(dungeon.mapIds.length == subArea.mapIds.length)
            {
               this._dungeons[pSubAreaId] = dungeonIds[0];
               return dungeonIds[0];
            }
            dungeons = [dungeon];
         }
         for each(dungeon in dungeons)
         {
            count = 0;
            if(dungeon.mapIds.length > subArea.mapIds.length)
            {
               for each(mapId in subArea.mapIds)
               {
                  if(dungeon.mapIds.indexOf(mapId) != -1)
                  {
                     count++;
                  }
               }
               if(count == subArea.mapIds.length)
               {
                  this._dungeons[pSubAreaId] = dungeon.id;
                  return dungeon.id;
               }
            }
            else
            {
               for each(mapId in dungeon.mapIds)
               {
                  if(subArea.mapIds.indexOf(mapId) != -1)
                  {
                     count++;
                  }
               }
               if(count == dungeon.mapIds.length)
               {
                  this._dungeons[pSubAreaId] = dungeon.id;
                  return dungeon.id;
               }
            }
            dungeonPos = mapApi.getMapPositionById(dungeon.entranceMapId);
            if(dungeonPos)
            {
               for each(mapId in subArea.mapIds)
               {
                  mapPos = mapApi.getMapPositionById(mapId);
                  if((mapPos) && ((!(mapPos.posX == dungeonPos.posX)) || (!(mapPos.posY == dungeonPos.posY))))
                  {
                     return -1;
                  }
               }
               this._dungeons[pSubAreaId] = dungeon.id;
               return dungeon.id;
            }
         }
         return -1;
      }
      
      private function getSubAreaCenter(pSubAreaId:int) : Object {
         var dungeon:Object = null;
         var entranceMapPos:MapPosition = null;
         var subArea:Object = null;
         var mapId:* = 0;
         var mapPos:MapPosition = null;
         if(this._dungeons[pSubAreaId])
         {
            dungeon = this.dataApi.getDungeon(this._dungeons[pSubAreaId]);
            entranceMapPos = mapApi.getMapPositionById(dungeon.entranceMapId);
            return new Point(entranceMapPos.posX,entranceMapPos.posY);
         }
         var center:Object = mapApi.getSubAreaCenter(pSubAreaId);
         if(!center)
         {
            subArea = mapApi.getSubArea(pSubAreaId);
            for each(mapId in subArea.mapIds)
            {
               mapPos = mapApi.getMapPositionById(mapId);
               if(mapPos)
               {
                  this._notVisible.push(pSubAreaId);
                  return new Point(mapPos.posX,mapPos.posY);
               }
            }
            return null;
         }
         return center;
      }
      
      private function disableAddFlag() : void {
         this._addingFlag = this.btn_flag.selected = false;
      }
      
      private function onFlagAdded(pFlagId:String, pWorldMapId:int, pX:int, pY:int, pColor:int, pFlagLegend:String) : void {
         sysApi.sendAction(new PlaySound("16039"));
         if((!(pFlagId.indexOf("flag_custom") == -1)) && (!mapViewer.getMapElement(pFlagId)))
         {
            mapViewer.addIcon(FLAGS_LAYER,pFlagId,this._flagUri,pX,pY,1,pFlagLegend,true,pColor);
         }
         mapViewer.updateMapElements();
      }
      
      override protected function onFlagRemoved(pFlagId:String, pWorldMapId:int) : void {
         super.onFlagRemoved(pFlagId,pWorldMapId);
         removeFlag(pFlagId);
      }
      
      override public function unload() : void {
         super.unload();
         sysApi.removeEventListener(this.onEnterFrame);
      }
      
      public function onEnterFrame() : void {
         if(this.ctrSubAreaInfo.visible)
         {
            this.ctrSubAreaInfo.x = this.popCtr.mouseX;
            this.ctrSubAreaInfo.y = this.popCtr.mouseY;
            if(mapViewer.useFlagCursor)
            {
               this.ctrSubAreaInfo.x = this.ctrSubAreaInfo.x + 20;
            }
         }
      }
      
      override public function onMapElementRightClick(pMap:Object, pTarget:Object) : void {
         if(pTarget.id.indexOf("flag_custom") != -1)
         {
            super.onMapElementRightClick(pMap,pTarget);
         }
      }
      
      public function onMapElementRollOver(pMap:Object, pTarget:Object) : void {
         uiApi.showTooltip(uiApi.textTooltipInfo(pTarget.legend),pTarget.bounds,false,"standard",7,1,3,null,null,null,"TextInfo");
      }
      
      public function onRelease(pTarget:Object) : void {
         switch(pTarget)
         {
            case this.btn_close:
               uiApi.unloadUi(uiApi.me().name);
               break;
            case this.btn_flag:
               if(!this._addingFlag)
               {
                  mapViewer.enabledDrag = false;
                  this._addingFlag = mapViewer.useFlagCursor = true;
               }
               else
               {
                  mapViewer.enabledDrag = true;
                  mapViewer.useFlagCursor = false;
                  this.disableAddFlag();
               }
               break;
            case this.btn_grid:
               this._gridDisplayed = !sysApi.getData("ShowMapGrid",true);
               sysApi.setData("ShowMapGrid",this._gridDisplayed,true);
               mapViewer.showGrid = this._gridDisplayed;
               this.btn_grid.selected = this._gridDisplayed;
               break;
            case mapViewer:
               if(this._addingFlag)
               {
                  addCustomFlag(mapViewer.currentMouseMapX,mapViewer.currentMouseMapY);
                  this.disableAddFlag();
               }
               this.ctrSubAreaInfo.x = this.popCtr.mouseX;
               this.ctrSubAreaInfo.y = this.popCtr.mouseY;
               this.ctrSubAreaInfo.visible = true;
               break;
         }
      }
      
      public function onPress(pTarget:Object) : void {
         if(pTarget == mapViewer)
         {
            this.ctrSubAreaInfo.visible = false;
         }
      }
      
      public function onRollOver(pTarget:Object) : void {
         var tooltipText:String = null;
         switch(pTarget)
         {
            case mapViewer:
               this.ctrSubAreaInfo.visible = true;
               if((!mapViewer.useFlagCursor) && (this._addingFlag))
               {
                  mapViewer.useFlagCursor = true;
               }
               break;
            case this.btn_flag:
               tooltipText = uiApi.getText("ui.map.flag");
               break;
            case this.btn_grid:
               tooltipText = uiApi.getText("ui.option.displayGrid");
               break;
         }
         if(tooltipText)
         {
            uiApi.showTooltip(uiApi.textTooltipInfo(tooltipText),pTarget,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(pTarget:Object) : void {
         if(pTarget == mapViewer)
         {
            this.ctrSubAreaInfo.visible = false;
            if(this._addingFlag)
            {
               mapViewer.useFlagCursor = false;
            }
         }
         else
         {
            uiApi.hideTooltip();
         }
      }
      
      public function onMapRollOver(pTarget:Object, pX:int, pY:int) : void {
         var subarea:Object = null;
         var mapId:uint = 0;
         var mapPosition:Object = null;
         var areaName:String = null;
         var subAreaText:String = pX + "," + pY;
         var mapIds:Object = mapApi.getMapIdByCoord(pX,pY);
         if(mapIds)
         {
            for each(mapId in mapIds)
            {
               mapPosition = mapApi.getMapPositionById(mapId);
               if(mapPosition.worldMap == this._currentWorldMap.id)
               {
                  subarea = mapApi.subAreaByMapId(mapId);
                  break;
               }
            }
            if(subarea)
            {
               areaName = subarea.area.name;
               subAreaText = subAreaText + ("\n" + areaName + (!(areaName == subarea.name)?"\n" + subarea.name:""));
            }
         }
         this.lblSubAreaInfo.text = subAreaText;
         this.ctrSubAreaInfoBg.height = this.lblSubAreaInfo.textHeight + 10;
         this.ctrSubAreaInfoBg.width = this.lblSubAreaInfo.textWidth + 10;
      }
   }
}
