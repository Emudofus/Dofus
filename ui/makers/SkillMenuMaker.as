package makers
{
   import d2actions.*;
   import d2hooks.*;
   import contextMenu.ContextMenuItem;
   
   public class SkillMenuMaker extends Object
   {
      
      public function SkillMenuMaker() {
         super();
      }
      
      public static var disabled:Boolean = false;
      
      private function onSkillClicked(ie:Object, skillInstanceId:uint) : void {
         Api.system.sendAction(new InteractiveElementActivation(ie.element,ie.position,skillInstanceId));
      }
      
      private function onDisabledSkillClicked(ie:Object, skillInstanceId:uint) : void {
         Api.modCommon.openPopup(Api.ui.getText("ui.popup.warning"),Api.ui.getText("ui.skill.disabled"),[Api.ui.getText("ui.common.ok")],null);
      }
      
      public function createMenu(data:*, param:Object) : Array {
         var cm:ContextMenuItem = null;
         var params:Array = null;
         var isDisabled:* = false;
         var skill:Object = null;
         var owner:String = null;
         var title:String = null;
         var menu:Array = new Array();
         var dead:Boolean = !Api.player.isAlive();
         var houseInformation:Object = Api.data.getHouseInformations(param[0].element.elementId);
         if(houseInformation)
         {
            owner = null;
            if(houseInformation.ownerName == Api.player.getPlayedCharacterInfo().name)
            {
               owner = Api.ui.getText("ui.house.myHome");
            }
            else if(houseInformation.ownerName != "")
            {
               owner = Api.ui.getText("ui.house.homeOf",houseInformation.ownerName);
            }
            
            title = houseInformation.name;
            if(owner)
            {
               title = title + (" - " + owner);
            }
            menu.push(ContextMenu.static_createContextMenuTitleObject(title));
         }
         else if(param[1])
         {
            menu.push(ContextMenu.static_createContextMenuTitleObject(param[1].name));
         }
         
         for each(skill in data)
         {
            isDisabled = (disabled) || (!skill.enabled) || (dead);
            params = [param[0],skill.instanceId];
            cm = ContextMenu.static_createContextMenuItemObject(skill.name,this.onSkillClicked,[param[0],skill.instanceId],isDisabled);
            if(isDisabled)
            {
               cm.addDisabledCallback(this.onDisabledSkillClicked,params);
            }
            menu.push(cm);
         }
         return menu;
      }
   }
}
