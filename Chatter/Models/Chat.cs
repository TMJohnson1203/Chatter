//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Chatter.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Chat
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Chat()
        {
            this.Likes = new HashSet<Like>();
            this.UserInfoes = new HashSet<UserInfo>();
        }
    
        public int ChatID { get; set; }
        public string MessageText { get; set; }
        public Nullable<int> NumOfLikes { get; set; }
        public string UserID { get; set; }
        public Nullable<int> LikeID { get; set; }
        public System.DateTime DateCreated { get; set; }
    
        public virtual Like Like { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Like> Likes { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<UserInfo> UserInfoes { get; set; }
    }
}
