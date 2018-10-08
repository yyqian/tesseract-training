#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int main(int argc, char **argv) {
    if (argc < 2) {
        cout << "./rm_blank FILE" << endl;
        return 1;
    }
    cout << "Processing: " << argv[1] << endl;
    ifstream fin(argv[1]);
    ofstream fout("tmp.txt");
    string line;
    while (getline(fin, line)) {
        if (line[0] == 9) {
            cout << line << endl;
        } else {
            fout << line << endl;
        }
    }
    fout.close();
    const char * p = argv[1];
    remove(p);
    return 0;
}