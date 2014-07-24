package ui
{
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.SystemApi;
   import d2components.Texture;
   import d2components.Label;
   import d2components.ButtonContainer;
   import d2components.TextArea;
   import d2actions.*;
   import d2hooks.*;
   import d2enums.ComponentHookList;
   
   public class ModuleInfo extends Object
   {
      
      public function ModuleInfo() {
         super();
      }
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var sysApi:SystemApi;
      
      public var tx_bg:Texture;
      
      public var lbl_title:Label;
      
      public var btn_close:ButtonContainer;
      
      public var btn_activateModule:ButtonContainer;
      
      public var btn_refuse:ButtonContainer;
      
      public var btn_accept:ButtonContainer;
      
      public var ta_details:TextArea;
      
      public var lbl_moduleName:Label;
      
      public var lbl_moduleAuthor:Label;
      
      public var lbl_moduleVersion:Label;
      
      public var lbl_moduleDofusVersion:Label;
      
      public var lbl_moduleDescription:Label;
      
      private var _module:Object;
      
      private var _confirmActivationCallback:Function;
      
      private var _isUpdate:Boolean;
      
      public function main(params:Object) : void {
         this._module = params.module;
         this._confirmActivationCallback = params.activationCallback;
         this.showModuleDetails(this._module);
         if(!params.details)
         {
            this.sysApi.sendAction(new InstalledModuleInfoRequest(this._module.id));
         }
         else
         {
            this.onApisHooksActionsList(params.details);
         }
         this.sysApi.addHook(ApisHooksActionsList,this.onApisHooksActionsList);
         this.btn_accept.visible = this.btn_refuse.visible = (!this._module.trusted) && (params.visibleBtns);
         this.btn_close.visible = !this.btn_refuse.visible;
         this.btn_activateModule.visible = this.btn_refuse.visible;
         this.lbl_title.visible = this.btn_refuse.visible;
         if(!this.btn_accept.visible)
         {
            this.tx_bg.height = this.tx_bg.height - 40;
         }
         this._isUpdate = params.isUpdate;
         if(this._isUpdate)
         {
            this.lbl_title.text = this.uiApi.getText("ui.module.marketplace.confirmationupdate");
            this.btn_activateModule.visible = false;
         }
         this.uiApi.addComponentHook(this.btn_activateModule,ComponentHookList.ON_RELEASE);
      }
      
      private function onApisHooksActionsList(modulePermissions:Object) : void {
         var str:String = null;
         var description:String = null;
         var txt:String = "";
         if((!this._module.trusted) && (modulePermissions.useNetwork))
         {
            txt = txt + ("<p><i>" + this.uiApi.getText("ui.module.marketplace.usenetwork") + "</i></p><br>");
         }
         if(modulePermissions.actions.length)
         {
            txt = txt + ("<p><b>Actions</b><br>" + this.uiApi.getText("ui.module.marketplace.actions") + this.uiApi.getText("ui.common.colon") + "<ul>");
            for each(str in modulePermissions.actions)
            {
               if(str != "IAction")
               {
                  description = this.dataApi.getActionDescriptionByName(str).description;
                  if(description)
                  {
                     if(description.charAt(description.length - 1) == ".")
                     {
                        description = description.slice(0,-1);
                     }
                     txt = txt + ("<li>" + description + "</li>");
                  }
                  else
                  {
                     txt = txt + ("<li>" + str + "</li>");
                  }
               }
            }
            txt = txt + "</ul></p>";
         }
         if(modulePermissions.apis.length)
         {
            txt = txt + ("<p><b>APIs</b><br>" + this.uiApi.getText("ui.module.marketplace.apis") + this.uiApi.getText("ui.common.colon") + "<ul>");
            for each(str in modulePermissions.apis)
            {
               txt = txt + ("<li>" + str + "</li>");
            }
            txt = txt + "</ul></p>";
         }
         if(modulePermissions.hooks.length)
         {
            txt = txt + ("<p><b>" + this.uiApi.getText("ui.common.events") + "</b><br>" + this.uiApi.getText("ui.module.marketplace.events") + this.uiApi.getText("ui.common.colon") + "<ul>");
            for each(str in modulePermissions.hooks)
            {
               txt = txt + ("<li>" + str + "</li>");
            }
            txt = txt + "</ul></p>";
         }
         this.ta_details.appendText(txt);
      }
      
      private function showModuleDetails(data:Object) : void {
         this.lbl_moduleName.text = data.name;
         this.lbl_moduleAuthor.text = data.author;
         this.lbl_moduleVersion.text = this.uiApi.getText("ui.common.version") + this.uiApi.getText("ui.common.colon") + data.version;
         this.lbl_moduleDofusVersion.text = this.uiApi.getText("ui.module.marketplace.dofusversion",data.dofusVersion);
         this.lbl_moduleDescription.text = this.uiApi.getText("ui.common.description") + this.uiApi.getText("ui.common.colon") + "\n" + data.description;
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btn_accept:
               if(this.btn_activateModule.selected)
               {
                  this._confirmActivationCallback();
               }
               this.sysApi.sendAction(new ModuleInstallConfirm(this._isUpdate));
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_refuse:
               this.sysApi.sendAction(new ModuleInstallCancel());
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
         }
      }
   }
}
