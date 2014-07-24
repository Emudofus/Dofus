package ui.items
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.PlayedCharacterApi;
   import d2api.DataApi;
   import d2api.ContextMenuApi;
   import d2components.Texture;
   import d2components.Label;
   import d2components.ButtonContainer;
   import d2hooks.*;
   import d2enums.PlayerStatusEnum;
   
   public class CrafterXmlItem extends Object
   {
      
      public function CrafterXmlItem() {
         super();
      }
      
      public var output:Object;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var dataApi:DataApi;
      
      public var menuApi:ContextMenuApi;
      
      public var modContextMenu:Object;
      
      private var _grid:Object;
      
      private var _data;
      
      private var _iconsPath:String;
      
      private var area:String;
      
      public var tx_alignment:Texture;
      
      public var tx_head:Texture;
      
      public var tx_loc:Texture;
      
      public var tx_status:Texture;
      
      public var lbl_name:Label;
      
      public var lbl_level:Label;
      
      public var lbl_loc:Label;
      
      public var lbl_notFree:Label;
      
      public var lbl_nbSlots:Label;
      
      public var btn_more:ButtonContainer;
      
      public function main(oParam:Object = null) : void {
         this._grid = oParam.grid;
         this._data = oParam.data;
         this.uiApi.addComponentHook(this.tx_loc,"onRollOver");
         this.uiApi.addComponentHook(this.tx_loc,"onRollOut");
         this.uiApi.addComponentHook(this.tx_loc,"onRightClick");
         this.uiApi.addComponentHook(this.tx_status,"onRollOver");
         this.uiApi.addComponentHook(this.tx_status,"onRollOut");
         this._iconsPath = this.uiApi.me().getConstant("icons_uri");
         this.update(this._data,false);
      }
      
      public function unload() : void {
      }
      
      public function get data() : * {
         return this._data;
      }
      
      public function update(data:*, selected:Boolean) : void {
         if(data)
         {
            this._data = data;
            this.lbl_name.text = "{player," + this._data.playerName + "," + this._data.playerId + "::" + this._data.playerName + "}";
            this.lbl_level.text = this._data.jobLevel;
            this.tx_status.visible = true;
            switch(data.statusId)
            {
               case PlayerStatusEnum.PLAYER_STATUS_AVAILABLE:
                  this.tx_status.uri = this.uiApi.createUri(this._iconsPath + "|available");
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_AFK:
               case PlayerStatusEnum.PLAYER_STATUS_IDLE:
                  this.tx_status.uri = this.uiApi.createUri(this._iconsPath + "|away");
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_PRIVATE:
                  this.tx_status.uri = this.uiApi.createUri(this._iconsPath + "|private");
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_SOLO:
                  this.tx_status.uri = this.uiApi.createUri(this._iconsPath + "|solo");
                  break;
            }
            this.tx_head.uri = this.uiApi.createUri(this.uiApi.me().getConstant("heads") + this._data.breed + "" + (this._data.sex?"0":"1") + ".png");
            if(this._data.alignmentSide > 0)
            {
               this.tx_alignment.uri = this.uiApi.createUri(this.uiApi.me().getConstant("alignment_uri") + this._data.alignmentSide);
            }
            else
            {
               this.tx_alignment.uri = null;
            }
            this.btn_more.visible = true;
            if(!this._data.isInWorkshop)
            {
               this.lbl_loc.text = "-";
               this.area = "";
            }
            else
            {
               this.lbl_loc.text = this._data.worldPos;
               this.area = this.dataApi.getArea(this.dataApi.getSubArea(this._data.subAreaId).areaId).name + " ( " + this.dataApi.getSubArea(this._data.subAreaId).name + " )";
            }
            if(this._data.notFree)
            {
               this.lbl_notFree.text = this.uiApi.getText("ui.common.yes");
            }
            else
            {
               this.lbl_notFree.text = this.uiApi.getText("ui.common.no");
            }
            this.lbl_nbSlots.text = this._data.minSlots;
         }
         else
         {
            this.lbl_name.text = "";
            this.lbl_level.text = "";
            this.lbl_loc.text = "";
            this.lbl_nbSlots.text = "";
            this.lbl_notFree.text = "";
            this.tx_alignment.uri = null;
            this.tx_head.uri = null;
            this.btn_more.visible = false;
            this.tx_status.visible = false;
         }
      }
      
      public function onRelease(target:Object) : void {
         if(target == this.btn_more)
         {
            if(!this.uiApi.getUi("crafterForm"))
            {
               this.uiApi.loadUi("crafterForm","crafterForm",this._data);
            }
         }
      }
      
      public function onRollOver(target:Object) : void {
         var tooltipText:String = null;
         if(this._data)
         {
            if(target.name == "tx_status")
            {
               switch(this._data.statusId)
               {
                  case PlayerStatusEnum.PLAYER_STATUS_AVAILABLE:
                     tooltipText = this.uiApi.getText("ui.chat.status.availiable");
                     break;
                  case PlayerStatusEnum.PLAYER_STATUS_IDLE:
                     tooltipText = this.uiApi.getText("ui.chat.status.idle");
                     break;
                  case PlayerStatusEnum.PLAYER_STATUS_AFK:
                     tooltipText = this.uiApi.getText("ui.chat.status.away");
                     if(this._data.awayMessage != null)
                     {
                        tooltipText = tooltipText + (this.uiApi.getText("ui.common.colon") + this._data.awayMessage);
                     }
                     break;
                  case PlayerStatusEnum.PLAYER_STATUS_PRIVATE:
                     tooltipText = this.uiApi.getText("ui.chat.status.private");
                     break;
                  case PlayerStatusEnum.PLAYER_STATUS_SOLO:
                     tooltipText = this.uiApi.getText("ui.chat.status.solo");
                     break;
               }
            }
            else if((target.name == "tx_loc") && (this._data.isInWorkshop) && (this.area))
            {
               tooltipText = this.area;
            }
            
            if(tooltipText)
            {
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",7,1,3,null,null,null,"TextInfo");
            }
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onRightClick(target:Object) : void {
         var data:Object = null;
         var contextMenu:Object = null;
         if(target.data)
         {
            data = target.data;
            contextMenu = this.menuApi.create(data);
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
   }
}
