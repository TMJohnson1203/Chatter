using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Chatter.Models;

namespace Chatter.Controllers
{
    public class UserInfoController : Controller
    {
        private ChatterEntities db = new ChatterEntities();

        // GET: UserInfo
        public ActionResult Index()
        {
            var userInfoes = db.UserInfoes.Include(u => u.Chat).Include(u => u.Follow);
            return View(userInfoes.ToList());
        }

        // GET: UserInfo/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            UserInfo userInfo = db.UserInfoes.Find(id);
            if (userInfo == null)
            {
                return HttpNotFound();
            }
            return View(userInfo);
        }

        // GET: UserInfo/Create
        public ActionResult Create()
        {
            ViewBag.ChatID = new SelectList(db.Chats, "ChatID", "MessageText");
            ViewBag.FollowID = new SelectList(db.Follows, "FollowID", "UserID");
            return View();
        }

        // POST: UserInfo/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "UserID,UserName,UserEmail,FollowID,ChatID")] UserInfo userInfo)
        {
            if (ModelState.IsValid)
            {
                db.UserInfoes.Add(userInfo);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.ChatID = new SelectList(db.Chats, "ChatID", "MessageText", userInfo.ChatID);
            ViewBag.FollowID = new SelectList(db.Follows, "FollowID", "UserID", userInfo.FollowID);
            return View(userInfo);
        }

        // GET: UserInfo/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            UserInfo userInfo = db.UserInfoes.Find(id);
            if (userInfo == null)
            {
                return HttpNotFound();
            }
            ViewBag.ChatID = new SelectList(db.Chats, "ChatID", "MessageText", userInfo.ChatID);
            ViewBag.FollowID = new SelectList(db.Follows, "FollowID", "UserID", userInfo.FollowID);
            return View(userInfo);
        }

        // POST: UserInfo/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "UserID,UserName,UserEmail,FollowID,ChatID")] UserInfo userInfo)
        {
            if (ModelState.IsValid)
            {
                db.Entry(userInfo).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.ChatID = new SelectList(db.Chats, "ChatID", "MessageText", userInfo.ChatID);
            ViewBag.FollowID = new SelectList(db.Follows, "FollowID", "UserID", userInfo.FollowID);
            return View(userInfo);
        }

        // GET: UserInfo/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            UserInfo userInfo = db.UserInfoes.Find(id);
            if (userInfo == null)
            {
                return HttpNotFound();
            }
            return View(userInfo);
        }

        // POST: UserInfo/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            UserInfo userInfo = db.UserInfoes.Find(id);
            db.UserInfoes.Remove(userInfo);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
