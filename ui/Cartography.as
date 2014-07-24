package 
{
   import flash.display.Sprite;
   import ui.CartographyUi;
   import ui.CartographyPopup;
   import ui.CartographyPocket;
   import d2api.UiApi;
   import d2api.SystemApi;
   import d2api.PlayedCharacterApi;
   import d2api.MapApi;
   import d2api.HighlightApi;
   import d2api.DataApi;
   import d2api.TimeApi;
   import d2api.ConfigApi;
   import d2data.WorldMap;
   import d2hooks.*;
   import ui.type.Flag;
   import d2enums.PrismStateEnum;
   import d2data.MapPosition;
   import ui.CartographyBase;
   import d2enums.ChatActivableChannelsEnum;
   import d2data.SubArea;
   
   public class Cartography extends Sprite
   {
      
      public function Cartography() {
         this._flags = new Array();
         super();
      }
      
      private var include_CartographyUi:CartographyUi;
      
      private var include_CartographyPopup:CartographyPopup;
      
      private var include_CartographyPocket:CartographyPocket;
      
      private var _currentWorldMapId:int;
      
      private var _flags:Array;
      
      private var _prismsStatesInfo:Array;
      
      public var uiApi:UiApi;
      
      public var sysApi:SystemApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var mapApi:MapApi;
      
      public var highlightApi:HighlightApi;
      
      public var dataApi:DataApi;
      
      public var timeApi:TimeApi;
      
      public var configApi:ConfigApi;
      
      public function main() : void {
         var wmap:WorldMap = null;
         var flagData:String = null;
         var worldFlagsData:Array = null;
         var dataStr:String = null;
         var worldId:* = 0;
         var flagsPos:Array = null;
         var j:* = 0;
         var x:* = 0;
         var y:* = 0;
         this.sysApi.addHook(OpenMap,this.onOpenMap);
         this.sysApi.addHook(AddMapFlag,this.onAddMapFlag);
         this.sysApi.addHook(RemoveMapFlag,this.onRemoveMapFlag);
         this.sysApi.addHook(RemoveAllFlags,this.onRemoveAllFlags);
         this.sysApi.addHook(CurrentMap,this.onCurrentMap);
         this.sysApi.addHook(OpenCartographyPopup,this.openCartographyPopup);
         this.sysApi.createHook("MapHintsFilter");
         this.sysApi.createHook("FlagAdded");
         this.sysApi.createHook("FlagRemoved");
         var wmaps:Object = this.dataApi.getAllWorldMaps();
         for each(wmap in wmaps)
         {
            this._flags[wmap.id] = [];
         }
         flagData = this.sysApi.getData(this.playerApi.getPlayedCharacterInfo().id + "-cartographyFlags");
         if(flagData)
         {
            worldFlagsData = flagData.split(";");
            for each(dataStr in worldFlagsData)
            {
               if(dataStr)
               {
                  worldId = parseInt(dataStr.split(":")[0]);
                  flagsPos = dataStr.split(":")[1].split(",");
                  j = 0;
                  while(j < flagsPos.length)
                  {
                     x = parseInt(flagsPos[j]);
                     y = parseInt(flagsPos[j + 1]);
                     this._flags[worldId]["flag_custom_" + x + "_" + y] = new Flag("flag_custom_" + x + "_" + y,x,y,this.uiApi.getText("ui.cartography.customFlag") + " (" + x + "," + y + ")",16768256);
                     j = j + 2;
                  }
               }
            }
         }
         this._prismsStatesInfo = new Array();
         this._prismsStatesInfo[PrismStateEnum.PRISM_STATE_INVULNERABLE] = 
            {
               "text":this.uiApi.getText("ui.prism.prismInState",this.uiApi.getText("ui.prism.state" + PrismStateEnum.PRISM_STATE_INVULNERABLE)),
               "icon":420
            };
         this._prismsStatesInfo[PrismStateEnum.PRISM_STATE_ATTACKED] = 
            {
               "text":this.uiApi.getText("ui.prism.prismInState",this.uiApi.getText("ui.prism.state" + PrismStateEnum.PRISM_STATE_ATTACKED)),
               "icon":420
            };
         this._prismsStatesInfo[PrismStateEnum.PRISM_STATE_FIGHTING] = 
            {
               "text":this.uiApi.getText("ui.prism.prismInState",this.uiApi.getText("ui.prism.state" + PrismStateEnum.PRISM_STATE_FIGHTING)),
               "icon":420
            };
         this._prismsStatesInfo[PrismStateEnum.PRISM_STATE_NORMAL] = 
            {
               "text":this.uiApi.getText("ui.prism.prismInState",this.uiApi.getText("ui.prism.state" + PrismStateEnum.PRISM_STATE_NORMAL)),
               "icon":420
            };
         this._prismsStatesInfo[PrismStateEnum.PRISM_STATE_WEAKENED] = 
            {
               "text":this.uiApi.getText("ui.prism.prismInState",this.uiApi.getText("ui.prism.state" + PrismStateEnum.PRISM_STATE_WEAKENED)),
               "icon":421
            };
         this._prismsStatesInfo[PrismStateEnum.PRISM_STATE_VULNERABLE] = 
            {
               "text":this.uiApi.getText("ui.prism.prismInState",this.uiApi.getText("ui.prism.state" + PrismStateEnum.PRISM_STATE_VULNERABLE)),
               "icon":436
            };
         this._prismsStatesInfo[PrismStateEnum.PRISM_STATE_DEFEATED] = 
            {
               "text":this.uiApi.getText("ui.prism.prismInState",this.uiApi.getText("ui.prism.state" + PrismStateEnum.PRISM_STATE_DEFEATED)),
               "icon":436
            };
         this._prismsStatesInfo[PrismStateEnum.PRISM_STATE_SABOTAGED] = 
            {
               "text":this.uiApi.getText("ui.prism.prismInState",this.uiApi.getText("ui.prism.state" + PrismStateEnum.PRISM_STATE_SABOTAGED)),
               "icon":440
            };
      }
      
      public function openCartographyPopup(title:String, selectedSubareaId:int, subareaIds:Object = null, subtitle:String = "") : String {
         var params:Object = new Object();
         params.title = title;
         params.selectedSubareaId = selectedSubareaId;
         params.subareaIds = subareaIds;
         params.subtitle = subtitle;
         this.uiApi.loadUi("cartographyPopup",null,params,3,null,true);
         return "cartographyPopup";
      }
      
      private function onOpenMap(ignoreSetting:Boolean = false, pocket:Boolean = true, conquest:Boolean = false) : void {
         var currentWorldMapId:* = 0;
         var flags:Array = null;
         var key:String = null;
         var phoenixesMaps:Object = null;
         var mapId:uint = 0;
         var mapPos:MapPosition = null;
         var flag:Flag = null;
         var uiName:String = pocket?"cartographyPocket":"cartographyUi";
         if(this.uiApi.getUi(uiName))
         {
            this.uiApi.unloadUi(uiName);
         }
         else if(this.playerApi.currentSubArea())
         {
            currentWorldMapId = this.mapApi.getCurrentWorldMap().id;
            flags = [];
            for(key in this._flags[currentWorldMapId])
            {
               flags[key] = this._flags[currentWorldMapId][key];
            }
            if(!this.playerApi.isAlive())
            {
               phoenixesMaps = this.mapApi.getPhoenixsMaps();
               for each(mapId in phoenixesMaps)
               {
                  mapPos = this.mapApi.getMapPositionById(mapId);
                  flag = new Flag("Phoenix_" + mapId,mapPos.posX,mapPos.posY,this.uiApi.getText("ui.common.phoenix"),14759203);
                  flags.push(flag);
               }
            }
            this.uiApi.loadUi(uiName,null,
               {
                  "currentMap":this.playerApi.currentMap(),
                  "flags":flags,
                  "conquest":conquest
               });
         }
         
      }
      
      private function onAddMapFlag(flagId:String, flagLegend:String, worldmapId:int, x:int, y:int, color:uint, removeIfPresent:Boolean = false, showHelpArrow:Boolean = false) : void {
         var mapUi:CartographyBase = null;
         var flag:Flag = null;
         if(this.uiApi.getUi("cartographyUi"))
         {
            mapUi = this.uiApi.getUi("cartographyUi").uiClass;
         }
         else if(this.uiApi.getUi("cartographyPocket"))
         {
            mapUi = this.uiApi.getUi("cartographyPocket").uiClass;
         }
         
         if(!this._flags[worldmapId])
         {
            this.sysApi.log(8,"Failed to add new map flag because the world " + worldmapId + " is not valid");
            return;
         }
         if(!this._flags[worldmapId][flagId])
         {
            flag = new Flag(flagId,x,y,flagLegend,color);
            if(this.mapApi.getCurrentWorldMap().id != worldmapId)
            {
               this.sysApi.dispatchHook(TextInformation,this.uiApi.getText("ui.cartography.flagAddedOnOtherMap",x,y),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,this.timeApi.getTimestamp());
            }
            if((mapUi) && (mapUi.currentWorldId == worldmapId))
            {
               mapUi.addFlag(flagId,flagLegend,x,y,color);
            }
            this._flags[worldmapId][flagId] = flag;
            this.sysApi.dispatchHook(FlagAdded,flagId,worldmapId,x,y,color,flagLegend);
            if((showHelpArrow) && (!this.playerApi.isInFight()))
            {
               this.highlightApi.highlightUi("banner","btn_map",1,0,5,false);
            }
         }
         else
         {
            flag = this._flags[worldmapId][flagId];
            if(removeIfPresent)
            {
               delete this._flags[worldmapId][flagId];
               if(this._currentWorldMapId != worldmapId)
               {
                  this.sysApi.dispatchHook(TextInformation,this.uiApi.getText("ui.cartography.flagRemovedOnOtherMap",x,y),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,this.timeApi.getTimestamp());
               }
               if((mapUi) && (mapUi.currentWorldId == worldmapId))
               {
                  mapUi.removeFlag(flagId);
               }
               this.sysApi.dispatchHook(FlagRemoved,flagId,worldmapId);
            }
            else
            {
               flag.position.x = x;
               flag.position.y = y;
               flag.legend = flagLegend;
               if((mapUi) && (this._currentWorldMapId == worldmapId))
               {
                  if(!mapUi.updateFlag(flagId,x,y,flagLegend))
                  {
                     mapUi.addFlag(flagId,flagLegend,x,y,color);
                  }
               }
               this.sysApi.dispatchHook(FlagAdded,flagId,worldmapId,x,y,color,flagLegend);
               if((showHelpArrow) && (!this.playerApi.isInFight()))
               {
                  this.highlightApi.highlightUi("banner","btn_map",1,0,5,false);
               }
            }
         }
         if(flagId.indexOf("flag_custom") != -1)
         {
            this.saveFlags();
         }
      }
      
      private function onRemoveMapFlag(flagId:String, worldMapId:int) : void {
         var wmapId:* = undefined;
         if(worldMapId != -1)
         {
            this.removeFlagFromWorldMap(worldMapId,flagId);
         }
         else
         {
            for(wmapId in this._flags)
            {
               this.removeFlagFromWorldMap(wmapId,flagId);
            }
         }
      }
      
      private function removeFlagFromWorldMap(pWorldMapId:uint, pFlagId:String) : void {
         var mapUi:CartographyBase = null;
         if(!this._flags[pWorldMapId][pFlagId])
         {
            return;
         }
         if(this.uiApi.getUi("cartographyUi"))
         {
            mapUi = this.uiApi.getUi("cartographyUi").uiClass;
         }
         else if(this.uiApi.getUi("cartographyPocket"))
         {
            mapUi = this.uiApi.getUi("cartographyPocket").uiClass;
         }
         
         delete this._flags[pWorldMapId][pFlagId];
         if((mapUi) && (mapUi.currentWorldId == pWorldMapId))
         {
            mapUi.removeFlag(pFlagId);
         }
         this.sysApi.dispatchHook(FlagRemoved,pFlagId,pWorldMapId);
         if(pFlagId.indexOf("flag_custom") != -1)
         {
            this.saveFlags();
         }
      }
      
      private function onRemoveAllFlags() : void {
         this.removeAllFlags();
      }
      
      private function removeAllFlags() : void {
         var mapUi:CartographyBase = null;
         var worldMapId:* = undefined;
         var flagId:String = null;
         if(this.uiApi.getUi("cartographyUi"))
         {
            mapUi = this.uiApi.getUi("cartographyUi").uiClass;
         }
         else if(this.uiApi.getUi("cartographyPocket"))
         {
            mapUi = this.uiApi.getUi("cartographyPocket").uiClass;
         }
         
         for(worldMapId in this._flags)
         {
            for(flagId in this._flags[worldMapId])
            {
               delete this._flags[worldMapId][flagId];
               if((mapUi) && (mapUi.currentWorldId == worldMapId))
               {
                  mapUi.removeFlag(flagId);
               }
               this.sysApi.dispatchHook(FlagRemoved,flagId,worldMapId);
            }
         }
         this.saveFlags();
      }
      
      private function onCurrentMap(pMapId:uint) : void {
         if(this.uiApi.getUi("cartographyUi"))
         {
            this.uiApi.unloadUi("cartographyUi");
         }
         var subArea:SubArea = this.mapApi.getMapPositionById(pMapId).subArea;
         this._currentWorldMapId = subArea.worldmap?subArea.worldmap.id:1;
      }
      
      private function removeOtherWorldMapFlags() : void {
         var flag:Flag = null;
         var wmapId:* = undefined;
         for(wmapId in this._flags)
         {
            if(wmapId != this._currentWorldMapId)
            {
               for each(flag in this._flags[wmapId])
               {
                  this.removeFlagFromWorldMap(wmapId,flag.id);
               }
            }
         }
      }
      
      public function getFlags(worldMapId:int) : Array {
         var f:Object = null;
         var phoenixesMaps:Object = null;
         var mapId:uint = 0;
         var mapPos:MapPosition = null;
         var flag:Flag = null;
         var flags:Array = new Array();
         for each(f in this._flags[worldMapId])
         {
            flags.push(f);
         }
         if(!this.playerApi.isAlive())
         {
            if(this.playerApi.currentMap())
            {
               phoenixesMaps = this.mapApi.getPhoenixsMaps();
               for each(mapId in phoenixesMaps)
               {
                  mapPos = this.mapApi.getMapPositionById(mapId);
                  flag = new Flag("Phoenix_" + mapId,mapPos.posX,mapPos.posY,this.uiApi.getText("ui.common.phoenix"),14759203);
                  flags.push(flag);
               }
            }
         }
         return flags;
      }
      
      private function saveFlags() : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function getPrismStateInfo(pPrismState:uint) : Object {
         return this._prismsStatesInfo[pPrismState];
      }
      
      public function showConquestInformation() : Boolean {
         var subArea:SubArea = null;
         var subAreas:Object = this.mapApi.getAllSubArea();
         for each(subArea in subAreas)
         {
            if((subArea.worldmap) && (subArea.worldmap.id == this._currentWorldMapId) && (subArea.capturable))
            {
               return true;
            }
         }
         return false;
      }
   }
}
