package ui.items
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.UtilApi;
   import d2components.Texture;
   import d2components.Label;
   import d2components.GraphicContainer;
   import d2components.ButtonContainer;
   import d2hooks.*;
   
   public class BarnItem extends Object
   {
      
      public function BarnItem() {
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var utilApi:UtilApi;
      
      public var tx_icon:Texture;
      
      public var tx_icon_back:Texture;
      
      public var tx_icon_up:Texture;
      
      public var tx_iconSpecialMount:Texture;
      
      public var tx_sex:Texture;
      
      public var lbl_name:Label;
      
      public var lbl_level:Label;
      
      public var mainCtr:GraphicContainer;
      
      public var btn_item:ButtonContainer;
      
      private var _grid:Object;
      
      private var _data;
      
      private var _selected:Boolean;
      
      public function main(oParam:Object = null) : void {
         this._grid = oParam.grid;
         this._data = oParam.data;
         this.uiApi.addComponentHook(this.btn_item,"onRollOver");
         this.uiApi.addComponentHook(this.btn_item,"onRollOut");
         this.update(this._data,this._selected);
      }
      
      public function get data() : * {
         return this._data;
      }
      
      public function get selected() : Boolean {
         return this._selected;
      }
      
      public function update(data:*, selected:Boolean) : void {
         this._data = data;
         if(data)
         {
            this.btn_item.selected = selected;
            this.btn_item.mouseEnabled = true;
            this.mainCtr.visible = true;
            if((data.model == 88) || (data.model == 89))
            {
               this.tx_icon.visible = false;
               this.tx_icon_back.visible = false;
               this.tx_icon_up.visible = false;
               this.tx_iconSpecialMount.visible = true;
               this.tx_iconSpecialMount.uri = this.uiApi.createUri(this.uiApi.me().getConstant("mounts") + "head_" + data.model + ".swf");
            }
            else if(data.colors)
            {
               this.tx_icon.visible = true;
               this.tx_icon_back.visible = true;
               this.utilApi.changeColor(this.tx_icon_back,data.colors[1],1);
               this.tx_icon_up.visible = true;
               this.utilApi.changeColor(this.tx_icon_up,data.colors[2],0);
               this.tx_iconSpecialMount.visible = false;
            }
            
            if(data.sex)
            {
               this.tx_sex.uri = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "gestionDragodinde_tx_pictoFemelle");
            }
            else
            {
               this.tx_sex.uri = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "gestionDragodinde_tx_pictoMale");
            }
            this.lbl_name.text = data.name;
            this.lbl_level.text = data.level;
         }
         else
         {
            this.btn_item.mouseEnabled = false;
            this.btn_item.selected = false;
            this.mainCtr.visible = false;
            this.tx_icon.visible = false;
            this.tx_icon_back.visible = false;
            this.tx_icon_up.visible = false;
            this.tx_sex.uri = null;
            this.lbl_name.text = "";
            this.lbl_level.text = "";
         }
      }
      
      public function select(b:Boolean) : void {
      }
      
      public function onRollOver(target:Object) : void {
         var info:String = null;
         var classCss:String = null;
         if(this._data)
         {
            switch(target)
            {
               case this.btn_item:
                  if(this._data.reproductionCount == -1)
                  {
                     classCss = "rightred";
                     info = this.uiApi.getText("ui.mount.castrated");
                  }
                  else if(this._data.reproductionCount == 20)
                  {
                     classCss = "rightred";
                     info = this.uiApi.getText("ui.mount.sterilized");
                  }
                  else if(this._data.fecondationTime > 0)
                  {
                     classCss = "rightblue";
                     info = this.uiApi.getText("ui.mount.fecondee") + " (" + this._data.fecondationTime + " " + this.uiApi.processText(this.uiApi.getText("ui.time.hours"),"m",this._data.fecondationTime == 1) + ")";
                  }
                  else if(this._data.isFecondationReady)
                  {
                     classCss = "rightgreen";
                     info = this.uiApi.getText("ui.mount.fecondable");
                  }
                  
                  
                  
                  break;
            }
            if(info)
            {
               this.uiApi.showTooltip(info,target,false,"standard",6,0,3,"text",null,
                  {
                     "css":"[local.css]normal.css",
                     "classCss":classCss
                  });
            }
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
   }
}
