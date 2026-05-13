---

in pv.yaml
 
to be changed 
 
line 4 -- name
line 5 -- Namespace 
 
line 16 -- path -- /srv/nfs/kubedata/30
label:
   type: fast-30

---

in pvc.yaml
 
to be changed 
line 4  -- name -- 
line 5 -- namespac e-- 
 
line 15 -- type: fast-30
---

in py-deploy.yaml
 
add the volumemounts
and 
volumes
 
and in the volumnount
Mounthpth: "/code

---
add namespace to all the 4 py-redis files 