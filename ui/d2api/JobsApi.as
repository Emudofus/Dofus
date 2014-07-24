package d2api
{
   import d2data.Job;
   import d2data.Skill;
   import d2data.Recipe;
   import d2data.KnownJob;
   
   public class JobsApi extends Object
   {
      
      public function JobsApi() {
         super();
      }
      
      public function destroy() : void {
      }
      
      public function getKnownJobs() : Object {
         return null;
      }
      
      public function getJobSkills(job:Job) : Object {
         return null;
      }
      
      public function getJobSkillType(job:Job, skill:Skill) : String {
         return null;
      }
      
      public function getJobCollectSkillInfos(job:Job, skill:Skill) : Object {
         return null;
      }
      
      public function getMaxSlotsByJobId(jobId:int) : int {
         return 0;
      }
      
      public function getJobCraftSkillInfos(job:Job, skill:Skill) : Object {
         return null;
      }
      
      public function getJobExperience(job:Job) : Object {
         return null;
      }
      
      public function getSkillFromId(skillId:int) : Object {
         return null;
      }
      
      public function getJobRecipes(job:Job, validSlotsCount:Object = null, skill:Skill = null, search:String = null) : Object {
         return null;
      }
      
      public function getRecipe(objectId:uint) : Recipe {
         return null;
      }
      
      public function getRecipesList(objectId:uint) : Object {
         return null;
      }
      
      public function getJobName(pJobId:uint) : String {
         return null;
      }
      
      public function getJob(pJobId:uint) : Object {
         return null;
      }
      
      public function getJobCrafterDirectorySettingsById(jobId:uint) : Object {
         return null;
      }
      
      public function getJobCrafterDirectorySettingsByIndex(jobIndex:uint) : Object {
         return null;
      }
      
      public function getUsableSkillsInMap(playerId:int) : Object {
         return null;
      }
      
      public function getKnownJob(jobId:uint) : KnownJob {
         return null;
      }
      
      public function getRecipesByJob(details:Object, jobMaxSlots:Object, jobId:int = 0, fromBank:Boolean = false, onlyRecipeWithXP:Boolean = false, onlyKnownJobs:Boolean = false, missingIngredientsTolerance:int = 0, sortCriteria:String = "level", sortDescending:Boolean = true, filterTypes:Object = null) : Object {
         return null;
      }
      
      public function sortRecipesByCriteria(recipes:Object, sortCriteria:String, sortDescending:Boolean) : Object {
         return null;
      }
   }
}
