package ui.items
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2components.Texture;
   import d2components.Label;
   import d2components.ButtonContainer;
   import d2hooks.*;
   
   public class ServerXmlItem extends Object
   {
      
      public function ServerXmlItem() {
         super();
      }
      
      public var output:Object;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      private var _assetsUri:String;
      
      private var _grid:Object;
      
      private var _data;
      
      private var _selected;
      
      public var tx_drapeau:Texture;
      
      public var tx_infoType:Texture;
      
      public var tx_infoState:Texture;
      
      public var lbl_infoName:Label;
      
      public var lbl_infoPopulation:Label;
      
      public var btn_server:ButtonContainer;
      
      public function main(oParam:Object = null) : void {
         this.btn_server.soundId = "0";
         this._grid = oParam.grid;
         this._data = oParam.data;
         this._selected = oParam.selected;
         this._assetsUri = this.uiApi.me().getConstant("assets");
         this.update(this._data,this._selected);
      }
      
      public function get data() : * {
         return this._data;
      }
      
      public function get selected() : Boolean {
         return this._selected;
      }
      
      public function update(data:*, selected:Boolean) : void {
         var serverData:Object = null;
         var popId:uint = 0;
         this._data = data;
         if(data)
         {
            serverData = this.dataApi.getServer(data.id);
            if(!serverData)
            {
               this.tx_drapeau.uri = null;
               this.tx_infoType.uri = null;
               this.tx_infoState.uri = null;
               this.lbl_infoName.text = "?";
               this.lbl_infoPopulation.text = "?";
            }
            else
            {
               this.lbl_infoName.text = data.name;
               this.tx_infoType.uri = this.uiApi.createUri(this._assetsUri + "type_" + serverData.gameTypeId);
               this.tx_infoState.uri = this.uiApi.createUri(this._assetsUri + "state_" + data.status);
               if(data.status == 7)
               {
                  this.uiApi.addComponentHook(this.tx_infoState,"onRollOver");
                  this.uiApi.addComponentHook(this.tx_infoState,"onRollOut");
               }
               if(this._data.completion >= 0)
               {
                  popId = this._data.completion;
                  if(popId == 4)
                  {
                     popId = 2;
                  }
                  this.lbl_infoPopulation.cssClass = "p" + popId;
                  this.lbl_infoPopulation.text = this.dataApi.getServerPopulation(popId).name;
               }
               else
               {
                  this.lbl_infoPopulation.cssClass = "p1";
                  this.lbl_infoPopulation.text = "?";
               }
               this.tx_drapeau.uri = this.uiApi.createUri(this.uiApi.me().getConstant("flag_uri") + "assets.swf|flag_" + this._data.community.toString());
               this.btn_server.selected = selected;
               this.btn_server.state = selected?this.sysApi.getEnum("com.ankamagames.berilia.enums.StatesEnum").STATE_SELECTED:this.sysApi.getEnum("com.ankamagames.berilia.enums.StatesEnum").STATE_NORMAL;
            }
            if(this.btn_server.disabled)
            {
               this.btn_server.disabled = false;
            }
         }
         else
         {
            this.tx_drapeau.uri = null;
            this.tx_infoType.uri = null;
            this.tx_infoState.uri = null;
            this.lbl_infoName.text = "";
            this.lbl_infoPopulation.text = "";
            this.btn_server.selected = false;
            this.btn_server.disabled = true;
         }
         if(!this.tx_infoType.finalized)
         {
            this.tx_infoType.finalize();
         }
         if(!this.tx_infoType.finalized)
         {
            this.tx_infoState.finalize();
         }
         if(!this.tx_infoType.finalized)
         {
            this.tx_drapeau.finalize();
         }
      }
      
      public function select(b:Boolean) : void {
         this.btn_server.selected = b;
      }
      
      public function unload() : void {
      }
      
      public function onRollOver(target:Object) : void {
         if(target == this.tx_infoState)
         {
            if(this._data.status == 7)
            {
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.server.cantChoose.serverFull.over")),target,false,"standard",7,1,3,null,null,null,"TextInfo");
            }
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
   }
}
