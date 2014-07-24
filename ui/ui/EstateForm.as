package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.UtilApi;
   import d2api.PlayedCharacterApi;
   import d2api.MapApi;
   import d2components.ButtonContainer;
   import d2components.Texture;
   import d2components.Label;
   import d2enums.ShortcutHookListEnum;
   import d2hooks.AddMapFlag;
   import d2hooks.ChatFocus;
   
   public class EstateForm extends Object
   {
      
      public function EstateForm() {
         super();
      }
      
      public var output:Object;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var utilApi:UtilApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var mapApi:MapApi;
      
      private var _data:Object;
      
      private var _estateType:uint;
      
      private var _skillsList:Array;
      
      public var btn_mp:ButtonContainer;
      
      public var btn_loc:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var tx_houseIcon:Texture;
      
      public var lbl_name:Label;
      
      public var lbl_priceContent:Label;
      
      public var lbl_nbRoomMount:Label;
      
      public var lbl_nbRoomMountContent:Label;
      
      public var lbl_nbChestMachine:Label;
      
      public var lbl_nbChestMachineContent:Label;
      
      public var lbl_skill:Label;
      
      public var lbl_locCoord:Label;
      
      public var lbl_locArea:Label;
      
      public var lbl_ownerContent:Label;
      
      public var lbl_openDoor:Label;
      
      public function main(args:Array) : void {
         this._estateType = args[0];
         this._data = args[1];
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortCut);
         this.sysApi.log(32,"go form pour " + this._data.price);
         this.updateInformations();
      }
      
      public function unload() : void {
      }
      
      private function updateInformations() : void {
         var house:* = undefined;
         var skill:uint = 0;
         if(this._estateType == 0)
         {
            house = this.dataApi.getHouse(this._data.modelId);
            this.lbl_nbRoomMount.text = this.uiApi.getText("ui.estate.nbRoom");
            this.lbl_nbChestMachine.text = this.uiApi.getText("ui.estate.nbChest");
            this.tx_houseIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("houses") + house.gfxId + ".png");
            this.lbl_name.text = house.name;
            this.lbl_priceContent.text = this.utilApi.kamasToString(this._data.price);
            if(this._data.isLocked)
            {
               this.lbl_openDoor.text = "";
            }
            else
            {
               this.lbl_openDoor.text = this.uiApi.getText("ui.estate.visit");
            }
            this.lbl_nbRoomMountContent.text = this._data.nbRoom;
            this.lbl_nbChestMachineContent.text = this._data.nbChest;
            this._skillsList = new Array();
            this.sysApi.log(2," skills : " + this._data.skillListIds.length);
            for each(skill in this._data.skillListIds)
            {
               this.sysApi.log(2," skill : " + skill);
               this._skillsList.push(this.dataApi.getSkill(skill).name);
            }
            if(this._skillsList.length)
            {
               this.lbl_skill.text = this.uiApi.processText(this.uiApi.getText("ui.estate.houseSkills",this._skillsList.length),"m",this._skillsList.length == 1);
               this.uiApi.addComponentHook(this.lbl_skill,"onRollOver");
               this.uiApi.addComponentHook(this.lbl_skill,"onRollOut");
            }
            else
            {
               this.lbl_skill.text = this.uiApi.getText("ui.estate.noSkill");
            }
            this.lbl_locCoord.text = this._data.worldX + "," + this._data.worldY;
            this.lbl_locArea.text = this.dataApi.getArea(this.dataApi.getSubArea(this._data.subAreaId).areaId).name + " ( " + this.dataApi.getSubArea(this._data.subAreaId).name + " )";
            this.sysApi.log(2," proprio : " + this._data.ownerName);
            if((!this._data.ownerName) || (this._data.ownerName == ""))
            {
               this.lbl_ownerContent.text = this.uiApi.getText("ui.common.none");
               this.btn_mp.disabled = true;
            }
            else
            {
               this.lbl_ownerContent.text = this._data.ownerName;
               this.btn_mp.disabled = false;
               if(!this._data.ownerConnected)
               {
                  this.lbl_ownerContent.text = this.lbl_ownerContent.text + (" (" + this.uiApi.getText("ui.server.state.offline") + ")");
               }
            }
         }
         else
         {
            this.lbl_skill.visible = false;
            this.btn_mp.visible = false;
            this.lbl_ownerContent.width = this.lbl_ownerContent.width + 30;
            this.lbl_nbRoomMount.text = this.uiApi.getText("ui.estate.nbMount");
            this.lbl_nbChestMachine.text = this.uiApi.getText("ui.estate.nbMachine");
            this.tx_houseIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus") + "enclos_tx_illuEnclos.png");
            this.lbl_name.text = this.uiApi.getText("ui.common.mountPark");
            this.lbl_priceContent.text = this.utilApi.kamasToString(this._data.price);
            this.lbl_openDoor.text = this.uiApi.getText("ui.estate.visit");
            this.lbl_nbRoomMountContent.text = this._data.nbMount;
            this.lbl_nbChestMachineContent.text = this._data.nbObject;
            this.lbl_locCoord.text = this._data.worldX + "," + this._data.worldY;
            this.lbl_locArea.text = this.dataApi.getArea(this.dataApi.getSubArea(this._data.subAreaId).areaId).name + " ( " + this.dataApi.getSubArea(this._data.subAreaId).name + " )";
            this.sysApi.log(2," proprio : " + this._data.guildOwner);
            if((!this._data.guildOwner) || (this._data.guildOwner == ""))
            {
               this.lbl_ownerContent.text = this.uiApi.getText("ui.common.none");
            }
            else
            {
               this.lbl_ownerContent.text = this._data.guildOwner;
            }
         }
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_loc:
               this.sysApi.dispatchHook(AddMapFlag,"flag_teleportPoint",this.lbl_name.text + " (" + this.lbl_locCoord.text + ")",this.mapApi.getCurrentWorldMap().id,this._data.worldX,this._data.worldY,15636787,true);
               break;
            case this.btn_mp:
               this.sysApi.dispatchHook(ChatFocus,"*" + this._data.ownerName);
               break;
         }
      }
      
      public function onRollOver(target:Object) : void {
         var tooltipText:String = null;
         var skill:* = undefined;
         if(target == this.lbl_skill)
         {
            tooltipText = "";
            for each(skill in this._skillsList)
            {
               tooltipText = tooltipText + (skill + " \n");
            }
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      private function onShortCut(s:String) : Boolean {
         if(s == "closeUi")
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return true;
         }
         return false;
      }
   }
}
