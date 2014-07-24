package ui
{
   import d2api.UiApi;
   import d2api.SystemApi;
   import d2api.ConfigApi;
   import types.ConfigProperty;
   import d2hooks.*;
   import d2actions.*;
   import d2components.GraphicContainer;
   
   public class ConfigUi extends Object
   {
      
      public function ConfigUi() {
         super();
      }
      
      public var uiApi:UiApi;
      
      public var sysApi:SystemApi;
      
      public var configApi:ConfigApi;
      
      protected var _properties:Array;
      
      public function init(configProperties:Array) : void {
         var configProperty:ConfigProperty = null;
         this._properties = configProperties;
         for each(configProperty in this._properties)
         {
            if(!configProperty.associatedProperty)
            {
               this.uiApi.me().getElement(configProperty.associatedComponent).disabled = true;
            }
            else
            {
               this.updateDisplay(configProperty,this.configApi.getConfigProperty(configProperty.associatedConfigModule,configProperty.associatedProperty),true);
            }
         }
         this.sysApi.addHook(ConfigPropertyChange,this.onConfigPropertyChange);
      }
      
      public function reset() : void {
         var configProperty:ConfigProperty = null;
         for each(configProperty in this._properties)
         {
            this.configApi.resetConfigProperty(configProperty.associatedConfigModule,configProperty.associatedProperty);
         }
      }
      
      public function setProperty(associatedConfigModule:String, associatedProperty:String, value:*) : void {
         var configProperty:ConfigProperty = null;
         for each(configProperty in this._properties)
         {
            if((associatedProperty == configProperty.associatedProperty) && (associatedConfigModule == configProperty.associatedConfigModule))
            {
               this.configApi.setConfigProperty(configProperty.associatedConfigModule,configProperty.associatedProperty,value);
               this.updateDisplay(configProperty,value);
               break;
            }
         }
      }
      
      public function showDefaultBtn(show:Boolean) : void {
         var mainContainer:Object = this.uiApi.getUi("optionContainer");
         if(mainContainer)
         {
            mainContainer.uiClass.btnDefault.visible = show;
         }
      }
      
      private function updateDisplay(configProperty:ConfigProperty, value:*, addHook:Boolean = false) : void {
         var cpt:Object = this.uiApi.me().getElement(configProperty.associatedComponent);
         switch(true)
         {
            case value is Boolean:
               cpt.selected = value;
               if(addHook)
               {
                  this.uiApi.addComponentHook(cpt as GraphicContainer,"onRelease");
               }
               break;
         }
      }
      
      public function onRelease(target:Object) : void {
         var configProperty:ConfigProperty = null;
         for each(configProperty in this._properties)
         {
            if(target.name == configProperty.associatedComponent)
            {
               this.configApi.setConfigProperty(configProperty.associatedConfigModule,configProperty.associatedProperty,target.selected);
               this.updateDisplay(configProperty,target.selected);
               break;
            }
         }
      }
      
      private function onConfigPropertyChange(target:String, name:String, value:*, oldValue:*) : void {
         var configProperty:ConfigProperty = null;
         for each(configProperty in this._properties)
         {
            if(target == configProperty.associatedProperty)
            {
               this.updateDisplay(configProperty,value);
               break;
            }
         }
      }
   }
}
