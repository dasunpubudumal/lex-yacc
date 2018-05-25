int gcd (int u, int v){
    if (v==0) return u ;
    /* Hello! from Comment */
    else return gcd(v, u-u/v*v);
}


void main(void) {
    int x; int y;
    x = input(); y = input();
    output(gcd(x, y));
}