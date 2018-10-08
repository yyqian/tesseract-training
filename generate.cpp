#include <iostream>
#include <cstdlib>
#include <string>
#include <sstream>
#include <fstream>

using namespace std;

int rand_n(int lo_include, int hi_include) {
    int range = hi_include - lo_include + 1;
    return (rand() % range) + lo_include;
}

char rand_0_X() {
    int n = rand_n(0, 10);
    if (n == 10) {
        return 'X';
    } else {
        return n + '0';
    }
}

string rand_month_day(int max) {
    int month = rand_n(1, max);
    ostringstream oss;
    if (month < 10) {
        oss << '0';
    }
    oss << month;
    return oss.str();
}

string rand_iss_date() {
    int year = rand_n(1970, 2020);
    string month = rand_month_day(12);
    string day = rand_month_day(31);
    ostringstream oss;
    oss << year << "年";
    oss << month << "月";
    oss << day << "日";
    return oss.str();
}

string rand_apno() {
    int year = rand_n(1980, 2020);
    int type = rand_n(1, 5); // 1,2,3,8,9
    if (type == 4) {
        type = 8;
    } else if (type == 5) {
        type = 9;
    }
    char corr = rand_0_X();
    ostringstream oss;
    oss << year << type;
    for (int i = 0; i < 7; ++i) {
        oss << rand_n(0, 9);
    }
    oss << '.' << corr;
    return oss.str();
}

string rand_iss_num() {
    int year = rand_n(1970, 2020);
    string month = rand_month_day(12);
    string day = rand_month_day(31);
    ostringstream oss;
    oss << year << month << day;
    for (int i = 0; i < 8; ++i) {
        oss << rand_n(0, 9);
    }
    return oss.str();
}

int main(int argc, char **argv) {
    cout << "Generating..." << endl;
    ofstream fz_hei_ofs("training_text/date.txt");
    ofstream times_bold_ofs("training_text/sn.txt");
    for (int i = 0; i < 5000; ++i) {
        fz_hei_ofs << rand_iss_date() << endl;
        times_bold_ofs << rand_iss_num() << endl;
        times_bold_ofs << rand_apno() << endl;
    }
    return 0;
}
