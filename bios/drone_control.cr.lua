local w,x,y,z,C,D,E,J,K,L="concat",table,computer,256,tostring,print,"uptime",string,xpcall,component
assert(K(function()local
B=1
local
t=8
local
M=8
local
function
I(n,g)g=g
or""local
f={}local
e=0
for
d=1,#n+1
do
local
a=d<=#n
and
n:byte(d)or
e
local
h=(g==""and
0)or
g:byte((d-1)%#g+1)e=(e-a)%z
f[d]=J.char((a+h)%z)end
return
x[w](f)end
local
function
n(g,f)f=f
or""local
e={}local
d=0
for
a=1,#g
do
local
h=(f==""and
0)or
f:byte((a-1)%#f+1)local
i=(g:byte(a)-h)%z
d=(d+i)%z
e[a]=J.char(i)end
if
d~=0
then
return
nil
end
return
x[w](e,"",1,#g-1)end
local
function
g(f,e,d)return"drone"..f.." "..I(d,e)end
local
function
f(e,d,a)local
h,i=a:match"^drone(%S+) (.-)$"if
h==e
then
return
n(i,d)end
end
local
function
e(d)local
a=L.list(d)()return
a
and
L.proxy(a)end
local
d=e"eeprom"local
a=e"drone"local
h=e"modem"local
i=e"leash"D=a.setStatusText
local
r,m,v=d.getData():match"^(%S*) (%S*) ?(.-)$"m=tonumber(m)D(r.."\n\n")h.open(B)h.open(m)local
k,j,l=0,0,0
local
function
s(b,c)if
b>c
then
b=c
elseif
b<-c
then
b=-c
end
return
b
end
local
b={[B]={id=function(b,c)h.send(b,c,g(r,v,"port("..m..")"))end,},[m]={move=function(b,c,q)k=k+b
j=j+c
l=l+q
end,swing=a.swing,swingUp=a.swingUp,swingDown=a.swingDown,place=a.place,placeUp=a.placeUp,placeDown=a.placeDown,select=a.select,count=function()local
b={}for
c=1,8
do
b[c]=C(a.count(c))end
return
x[w](b," ")end,space=function()local
b={}for
c=1,8
do
b[c]=C(a.space(c))end
return
x[w](b," ")end,leash=i
and
i.leash,unleash=i
and
i.unleash,},}local
c=y[E]()while
true
do
local
q=c-y[E]()if
q<=0
then
k=s(k,t)j=s(j,t)l=s(l,t)a.move(k,j,l)D(k..","..j..","..l)k,j,l=0,0,0
c=y[E]()+1
q=1
end
local
F,O,G,H,N,o=y.pullSignal(q)if
F=="modem_message"and
type(o)=="string"then
local
A=b[H]if
A
then
o=f(r,v,o)if
o
then
local
u,p=load(o,nil,nil,setmetatable({},{__index=A}))if
u
then
u,p=K(u,debug.traceback)end
if
p~=nil
then
p=C(p)h.send(G,m,g(r,v,("status%q"):format(p)))end
end
end
end
end
end,debug.traceback))