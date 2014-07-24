package ui.items
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2components.Texture;
   import d2components.Label;
   import d2components.GraphicContainer;
   import d2components.ButtonContainer;
   import d2hooks.*;
   
   public class ServerImgXmlItem extends Object
   {
      
      public function ServerImgXmlItem() {
         super();
      }
      
      public var output:Object;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      private var _assetsUri:String;
      
      private var _fallback:Boolean = false;
      
      private var _grid:Object;
      
      private var _data;
      
      private var _selected;
      
      public var tx_illu:Texture;
      
      public var tx_nbCharacters:Texture;
      
      public var tx_type:Texture;
      
      public var tx_status:Texture;
      
      public var lbl_name:Label;
      
      public var lbl_status:Label;
      
      public var lbl_nbCharacters:Label;
      
      public var ctr_server:GraphicContainer;
      
      public var btn_server:ButtonContainer;
      
      public function main(oParam:Object = null) : void {
         this.btn_server.soundId = "0";
         this._grid = oParam.grid;
         this._data = oParam.data;
         this._selected = oParam.selected;
         this.sysApi.addHook(TextureLoadFailed,this.onIlluLoadFailed);
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
         this._data = data;
         if(data)
         {
            serverData = this.dataApi.getServer(data.id);
            if(!serverData)
            {
               this.tx_illu.uri = null;
               this.tx_status.uri = null;
               this.tx_type.uri = null;
               this.tx_nbCharacters.uri = null;
               this.lbl_name.text = "";
               this.lbl_nbCharacters.text = "";
               this.lbl_status.text = "";
               this.ctr_server.visible = false;
            }
            else
            {
               this.tx_illu.dispatchMessages = true;
               this.tx_illu.finalized = true;
               this._fallback = false;
               this.tx_illu.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus_uri") + "assets.swf|illu_" + data.id);
               this.lbl_name.text = serverData.name;
               this.tx_status.uri = this.uiApi.createUri(this._assetsUri + "state_" + data.status);
               if(data.status == 7)
               {
                  this.uiApi.addComponentHook(this.tx_status,"onRollOver");
                  this.uiApi.addComponentHook(this.tx_status,"onRollOut");
               }
               this.lbl_status.text = this.uiApi.me().getConstant("status_" + data.status);
               if(data.charactersCount > 5)
               {
                  this.tx_nbCharacters.gotoAndStop = "7";
                  this.lbl_nbCharacters.text = "x " + data.charactersCount;
               }
               else
               {
                  this.tx_nbCharacters.gotoAndStop = (data.charactersCount + 1).toString();
                  this.lbl_nbCharacters.text = "";
               }
               this.tx_type.uri = this.uiApi.createUri(this._assetsUri + "type_" + serverData.gameTypeId);
               this.btn_server.selected = selected;
               this.btn_server.state = selected?this.sysApi.getEnum("com.ankamagames.berilia.enums.StatesEnum").STATE_SELECTED:this.sysApi.getEnum("com.ankamagames.berilia.enums.StatesEnum").STATE_NORMAL;
            }
         }
         else
         {
            this.tx_illu.uri = null;
            this.tx_status.uri = null;
            this.tx_type.uri = null;
            this.tx_nbCharacters.uri = null;
            this.lbl_name.text = "";
            this.lbl_nbCharacters.text = "";
            this.lbl_status.text = "";
            this.ctr_server.visible = false;
            this.btn_server.selected = false;
         }
      }
      
      public function select(b:Boolean) : void {
         this.btn_server.selected = b;
      }
      
      public function unload() : void {
      }
      
      public function onRollOver(target:Object) : void {
         if(target == this.tx_status)
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
      
      public function onIlluLoadFailed(target:Object, behavior:Object) : void {
         if((target == this.tx_illu) && (!this._fallback))
         {
            behavior.cancel = true;
            this._fallback = true;
            this.tx_illu.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus_uri") + "assets.swf|illu_0");
         }
      }
   }
}
